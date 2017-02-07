//
//  Location.swift
//  Crumbs
//
//  Created by Forrest Zhao on 2/7/17.
//  Copyright © 2017 ForrestApps. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct Location {
    
    var crumbKey: String
    var key: String
    var name: String
    var latitude: Double
    var longitude: Double
    var placeInLine: Int
    var description: String?
    
    let ref: FIRDatabaseReference?
    
    init(crumbKey: String, name: String, latitude: Double, longitude: Double, placeInLine: Int, key: String = "") {
        self.crumbKey = crumbKey
        self.key = key
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.placeInLine = placeInLine
        self.ref = nil
        self.description = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.crumbKey = snapshotValue["crumbKey"] as! String
        self.name = snapshotValue["name"] as! String
        self.latitude = snapshotValue["latitude"] as! Double
        self.longitude = snapshotValue["longitude"] as! Double
        self.placeInLine = snapshotValue["placeInLine"] as! Int
        self.description = snapshotValue["description"] as? String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "crumbKey": crumbKey,
            "name": name,
            "latitude": latitude,
            "longitude": longitude,
            "placeInLine": placeInLine,
            "description": description!
        ]
    }
    
}
