//
//  User.swift
//  Crumbs
//
//  Created by Forrest Zhao on 2/20/17.
//  Copyright © 2017 ForrestApps. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct User {
    
    let key: String
    let name: String
    let profileUrl: String
    let trails: [String: Bool]
    let ref: FIRDatabaseReference?
    
    init(key: String = "", name: String, profileUrl: String, trails: [String: Bool]) {
        self.key = key
        self.name = name
        self.profileUrl = profileUrl
        self.trails = trails
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key  = snapshot.key
        let snapshotValue = snapshot.value as! [String: Any]
        self.name = snapshotValue["name"] as! String
        self.profileUrl = snapshotValue["profileUrl"] as! String
        self.trails = snapshotValue["trails"] as! [String: Bool]
        ref = snapshot.ref
    }
    
    func convertToFirebaseJSON() -> Any {
        return [
            "name": name,
            "profileUrl": profileUrl,
            "trails": trails
        ]
    }
}
