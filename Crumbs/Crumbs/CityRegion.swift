//
//  CityRegion.swift
//  Crumbs
//
//  Created by Forrest Zhao on 2/7/17.
//  Copyright © 2017 ForrestApps. All rights reserved.
//

import Foundation
import MapKit

struct CityRegion {
    var name: String
    var coordinate: (latitude: Double, longitude: Double) {
        didSet {
            // TODO: - Set region
        }
    }
    var region: MKCoordinateRegion
}
