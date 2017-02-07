//
//  Trail.swift
//  Crumbs
//
//  Created by Forrest Zhao on 2/7/17.
//  Copyright © 2017 ForrestApps. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct Crumb {
    
    var key: String
    var userKey: String
    var name: String
    var city: String
    var likes: Int
    let ref: FIRDatabaseReference?
    
    init(name: String, key: String = "", userKey: String, city: String, likes: Int) {
        self.key = key
        self.name = name
        self.userKey = userKey
        self.city = city
        self.ref = nil
        self.likes = 0
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.name = snapshotValue["name"] as! String
        self.userKey = snapshotValue["userKey"] as! String
        if let unwrappedCityName = snapshotValue["city"] {
            self.city =  unwrappedCityName as! String
        }
        else {
            self.city = ""
        }
        self.likes = snapshotValue["likes"] as! Int
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "userKey": userKey,
            "city": city,
            "likes": likes
        ]
    }
    
}
