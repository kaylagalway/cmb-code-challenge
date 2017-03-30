//
//  HomeViewModel.swift
//  cmbCodeChallenge
//
//  Created by Kayla Galway on 3/29/17.
//  Copyright © 2017 Kayla Galway. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewModelDelegate: class {
    func dataDidLoad()
    func imageDidLoad(atIndexPath indexPath: IndexPath)
}

class HomeViewModel: NSObject {
    
    weak var delegate: HomeViewModelDelegate?
    var teammateArray = [TeammateModel]()
    var imageDictionary = [IndexPath: UIImage]()
    
    
    func fetchTableViewData() {
        APIManager.fetchImageJson() { [weak self] responseJSON in
            guard responseJSON != nil else {
                return
            }
            self?.initializeImageModels(withArray: responseJSON!)
        }
    }
    
    fileprivate func initializeImageModels(withArray dictArray: [[String: Any]]) {
        for dict in dictArray {
            guard let teammate = TeammateModel(withDictionary: dict) else {
                continue
            }
            teammateArray.append(teammate)
        }
        DispatchQueue.main.async {
            self.delegate?.dataDidLoad()
        }
    }
    
    func image(forIndexPath indexPath: IndexPath) -> UIImage? {
        guard indexPath.row <= teammateArray.count else {
            return nil
        }
        //check if already downloaded
        if imageDictionary[indexPath] != nil {
            return imageDictionary[indexPath]
        }
        //if not in cache, download
        fetchImage(atIndexPath: indexPath)
        return nil
    }
    
    fileprivate func fetchImage(atIndexPath indexPath: IndexPath) {
        let teammateIndex = indexPath.row
        let teammate = teammateArray[teammateIndex]
        APIManager.fetchImage(fromURL: teammate.avatarUrl) { [weak self] image in
            if let thumbnailImage = image {
                teammate.avatar = thumbnailImage
                self?.imageDictionary[indexPath] = thumbnailImage
            }
            self?.delegate?.imageDidLoad(atIndexPath: indexPath)
        }
    }
    
}
