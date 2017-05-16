//
//  Trail.swift
//  Crumbs
//
//  Created by Forrest Zhao on 2/7/17.
//  Copyright © 2017 ForrestApps. All rights reserved.
//

import UIKit
import SwiftyJSON
import FirebaseDatabase

struct Trail {
    
    var key: String
    var name: String
    var city: String
    var likes: Int
    var locations: [String: Location] = [:]
    let ref: FIRDatabaseReference?
    
    init(key: String = "", name: String, city: String, likes: Int, locations: [String: Location]) {
        self.key = key
        self.name = name
        self.city = city
        self.locations = locations
        self.likes = 0
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        self.name = snapshot.json["name"].stringValue
        self.city = snapshot.json["city"].stringValue
        self.likes = snapshot.json["likes"].intValue
        let locationObjects = snapshot.json["locations"].dictionaryValue
        for (key, value) in locationObjects {
            locations[key] = Location(dict: value)
        }
        ref = snapshot.ref
    }
    
    func convertToFirebaseJSON() -> Any {
        return [
            "name": name,
            "city": city,
            "likes": likes,
        ]
    }
}

struct Location {
    
    var name: String
    var latitude: Double
    var longitude: Double
    var placeInLine: Int
    
    init(dict: JSON) {
        self.name = dict["name"].stringValue
        self.latitude = dict["latitude"].doubleValue
        self.longitude = dict["longitude"].doubleValue
        self.placeInLine = dict["placeInLine"].intValue
    }
    
}
