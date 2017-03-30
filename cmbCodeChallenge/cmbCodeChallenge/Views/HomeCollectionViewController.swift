//
//  HomeCollectionViewController.swift
//  cmbCodeChallenge
//
//  Created by Kayla Galway on 3/29/17.
//  Copyright © 2017 Kayla Galway. All rights reserved.
//

import Foundation
import UIKit

class HomeCollectionViewController: UICollectionViewController, HomeViewModelDelegate {
    
    var viewModel = HomeViewModel()
    fileprivate let reuseIdentifier = "teammateCell"
    
    override func viewDidLoad() {
        viewModel.delegate = self
        viewModel.fetchTableViewData()
        collectionView?.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func dataDidLoad() {
        collectionView?.reloadData()
    }
    
    func imageDidLoad(atIndexPath indexPath: IndexPath) {
        collectionView?.reloadItems(at: [indexPath])
    }
    
}

//create collection view
extension HomeCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return viewModel.teammateArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,for: indexPath) as! HomeCollectionViewCell
        cell.teammateLabel.text = "TEAMMATE"
        cell.teammateLabel.textColor = UIColor.black
        cell.backgroundColor = UIColor.lightGray
        return cell
    }
    
    func setupFlowLayout() {
        
    }
    
}

//Set up constraints
extension HomeCollectionViewController {
    
    
    
}
