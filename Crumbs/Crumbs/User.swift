//
//  User.swift
//  Crumbs
//
//  Created by Forrest Zhao on 2/20/17.
//  Copyright © 2017 ForrestApps. All rights reserved.
//

import SwiftyJSON
import UIKit
import FirebaseDatabase

struct User {
    
    let key: String
    let name: String
    let userName: String
    let trails: [String: Bool]
    var profileImage: UIImage?
    var profileImageUrl: String
    let ref: FIRDatabaseReference?
    
    init(firstName: String, lastName: String, userName: String) {
        self.key = ""
        self.name = "\(firstName) \(lastName)"
        self.userName = userName
        self.trails = [:]
        self.profileImageUrl = ""
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key  = snapshot.key
        self.name = snapshot.json["name"].stringValue
        self.userName = snapshot.json["username"].stringValue
        self.trails = snapshot.json["trails"].dictionaryObject as! [String : Bool]
        self.profileImageUrl = snapshot.json["profileImageUrl"].stringValue
        ref = snapshot.ref
    }
    
    func convertToFirebaseJSON() -> [String: Any] {
        return [
            "name": name,
            "username": userName,
            "trails": trails,
            "profileImageUrl": profileImageUrl
        ]
    }
}
