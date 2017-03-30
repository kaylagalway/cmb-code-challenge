//
//  APIManagerSpy.swift
//  cmbCodeChallenge
//
//  Created by Kayla Galway on 3/29/17.
//  Copyright © 2017 Kayla Galway. All rights reserved.
//

import Foundation
import Alamofire


struct APIManager {
    
    //Method to demonstrate same behavior as async JSON fetch
    static func fetchImageJson(withCompletion completion: @escaping ([[String: Any]]?) -> Void) {
        let teammatesJson = FullTeamModel().teamArray
        completion(teammatesJson)
    }
    
    static func fetchImage(fromURL url: URL,completion: @escaping (UIImage?) -> Void) {
        Alamofire.request(url, encoding: URLEncoding.default).responseJSON { response in
            guard let imageData = response.data else {
                completion(nil)
                return
            }
            guard let image = UIImage(data: imageData) else {
                completion(nil)
                return
            }
            completion(image)
        }
    }
    
}
