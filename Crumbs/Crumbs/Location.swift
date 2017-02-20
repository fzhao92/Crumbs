////
////  Location.swift
////  Crumbs
////
////  Created by Forrest Zhao on 2/7/17.
////  Copyright © 2017 ForrestApps. All rights reserved.
////
//
//import UIKit
//import FirebaseDatabase
//
//struct Location {
//    
//    var key: String
//    var name: String
//    var latitude: Double
//    var longitude: Double
//    var placeInLine: Int
//    
//    let ref: FIRDatabaseReference?
//    
//    init(key: String = "", name: String, latitude: Double, longitude: Double, placeInLine: Int) {
//        self.key = key
//        self.name = name
//        self.latitude = latitude
//        self.longitude = longitude
//        self.placeInLine = placeInLine
//        self.ref = nil
//    }
//    
//    init(snapshot: FIRDataSnapshot) {
//        key = snapshot.key
//        let snapshotValue = snapshot.value as! [String: AnyObject]
//        self.name = snapshotValue["name"] as! String
//        self.latitude = snapshotValue["latitude"] as! Double
//        self.longitude = snapshotValue["longitude"] as! Double
//        self.placeInLine = snapshotValue["placeInLine"] as! Int
//        ref = snapshot.ref
//    }
//    
//    func toAnyObject() -> Any {
//        return [
//            "name": name,
//            "latitude": latitude,
//            "longitude": longitude,
//            "placeInLine": placeInLine,
//        ]
//    }
//    
//}
