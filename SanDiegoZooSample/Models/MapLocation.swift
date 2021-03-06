//
//  MapLocation.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import CoreLocation


class MapLocationSign: ZooObject {
    
    var number: Int
    
    init(coordinate: CLLocationCoordinate2D, areaPointer: Int, number: Int) {
        self.number = number
        
        super.init(
            name: "Map Location " + String(number),
            coordinate: coordinate,
            areaPointer: areaPointer,
            type: .mapLocation
        )
    }
}
