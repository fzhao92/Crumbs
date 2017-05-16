//
//  Extensions.swift
//  Crumbs
//
//  Created by Forrest Zhao on 2/20/17.
//  Copyright © 2017 ForrestApps. All rights reserved.
//

import SwiftyJSON
import Firebase

extension FIRDataSnapshot {
    var json : JSON {
        return JSON(self.value)
    }
}

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
