//
//  MapLocationData.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import CoreLocation


struct MapLocationData {
    
    lazy var mapLocations: [MapLocationSign] = {
        
        let mapLocationList = [
            MapLocationSign(coordinate: CLLocationCoordinate2DMake(32.734242, -117.149261),
                            areaPointer: 0,
                            number: 1),
            MapLocationSign(coordinate: CLLocationCoordinate2DMake(32.734481, -117.149423),
                            areaPointer: 0,
                            number: 2),
            MapLocationSign(coordinate: CLLocationCoordinate2DMake(32.734798, -117.149612),
                            areaPointer: 1,
                            number: 3)
        ]
        
        return mapLocationList
        
    }()
    
}
