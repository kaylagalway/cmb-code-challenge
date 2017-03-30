//
//  Teammate.swift
//  cmbCodeChallenge
//
//  Created by Kayla Galway on 3/29/17.
//  Copyright © 2017 Kayla Galway. All rights reserved.
//

import Foundation
import UIKit

struct TeammateConstants {
    static let avatar = "avatar"
    static let bio = "bio"
    static let firstName = "firstName"
    static let id = "id"
    static let lastName = "lastName"
    static let title = "title"
}

class TeammateModel: NSObject {
    
    fileprivate typealias Constants = TeammateConstants
    var id: String
    var avatar: UIImage?
    var avatarUrl: URL
    var bio: String
    var firstName: String
    var lastName: String
    var title: String
    
    
    init?(withDictionary teamDict: [String: Any]) {
        guard let teammateID = teamDict[Constants.id] as? String else {
            return nil
        }
        id = teammateID
        
        guard let teammateUrlString = teamDict[Constants.avatar] as? String else {
            return nil
        }
        guard let teammateUrl = URL(string: teammateUrlString) else {
            return nil
        }
        avatarUrl = teammateUrl
        
        guard let teammateBio = teamDict[Constants.bio] as? String else {
            return nil
        }
        bio = teammateBio
        
        guard let teammateFirst = teamDict[Constants.firstName] as? String else {
            return nil
        }
        firstName = teammateFirst
        
        guard let teammateLast = teamDict[Constants.lastName] as? String else {
            return nil
        }
        lastName = teammateLast
        
        guard let teammateTitle = teamDict[Constants.title] as? String else {
            return nil
        }
        title = teammateTitle
    }
    
}
