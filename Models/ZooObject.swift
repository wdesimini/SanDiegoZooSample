//
//  ZooObject.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import CoreLocation


class ZooObject: NSObject {
    
    var name: String
    var coordinate: CLLocationCoordinate2D
    var areaPointer: Int
    var type: ZooObjectType
    
    init(name: String, coordinate: CLLocationCoordinate2D, imageString: String? = nil, areaPointer: Int, type: ZooObjectType = .unknown, summary: String? = "No Summary Found") {
        self.name = name
        self.coordinate = coordinate
        self.imageString = imageString
        self.areaPointer = areaPointer
        self.type = type
        self.summary = summary
    }
    
    var imageString: String?
    var summary: String? = "No Summary Found"
    
    var area: ZooArea! {
        return ZooArea(rawValue: areaPointer)
    }
}

extension ZooObject: Comparable {
    static func < (lhs: ZooObject, rhs: ZooObject) -> Bool {
        return lhs.name.lowercased() < rhs.name.lowercased()
    }
}
