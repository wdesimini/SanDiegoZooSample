//
//  ZooObject.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import CoreLocation

//private let defaultImage = UIImage(named: "zoo_logo")

class ZooObject: NSObject {
    
    var name: String
    var coordinate: CLLocationCoordinate2D
    var imageString: String?
    var areaPointer: Int
    var type: ZooObjectType
    var summary: String?
    
    init(name: String, coordinate: CLLocationCoordinate2D, imageString: String? = nil, areaPointer: Int, type: ZooObjectType = .unknown, summary: String? = "No Summary Found") {
        self.name = name
        self.coordinate = coordinate
        self.imageString = imageString
        self.areaPointer = areaPointer
        self.type = type
        self.summary = summary
    }
    
    var area: ZooArea! {
        return ZooArea(rawValue: areaPointer)
    }
}

enum ZooObjectType {
    case animal, dining, shopping, catering, aviary, mapLocation, parkingLotSign, general, waterFountain, restroom, unknown
}
