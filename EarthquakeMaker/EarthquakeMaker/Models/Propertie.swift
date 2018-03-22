//
//  Properties.swift
//  EarthquakeMaker
//
//  Created by Ishan on 3/22/18.
//  Copyright © 2018 Ishan. All rights reserved.
//

import UIKit
import ObjectMapper

class Propertie: Mappable {
    var mag: Decimal?
    var place: String?
    var time: Int?
    //var updated: Int?
    var timeZone: Int?
//    var url: String?
//    var detail: String?
//    var felt:Integer?
//    var cdi: Decimal?
//    var mmi: Decimal?
//    var alert: String?
//    var status: String?
//    var tsunami: Integer?
//    var sig:Integer?
//    var net: String?
//    var code: String?
//    var ids: String?
//    var sources: String?
//    var types: String?
//    var nst: Integer?
//    var dmin: Decimal?
//    var rms: Decimal?
//    var gap: Decimal?
//    var magType: String?
//    var type: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        mag <- map["mag"]
        place <- map["place"]
        time <- map["time"]
        timeZone <- map["tz"]
    }
}

