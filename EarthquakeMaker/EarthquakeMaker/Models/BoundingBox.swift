//
//  BoundingBox.swift
//  EarthquakeMaker
//
//  Created by Ishan on 3/23/18.
//  Copyright © 2018 Ishan. All rights reserved.
//

import UIKit
import ObjectMapper

class BoundingBox: Mappable {
    var minimumlongitude: Double?
    var minimumLatitude: Double?
    var minimumDepth: Double?
    var maximumLongitude: Double?
    var maximumLatitude: Double?
    var maximumDepth: Double?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        minimumLatitude <- map[""]
        minimumLatitude <- map[""]
        minimumLatitude <- map[""]
        minimumLatitude <- map[""]
        minimumLatitude <- map[""]
        minimumLatitude <- map[""]
    }
}
