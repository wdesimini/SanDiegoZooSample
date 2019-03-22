//
//  WaterFountainData.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import CoreLocation


struct WaterFountainData {
    
    lazy var waterFountains: [WaterFountain] = {
        
        let fountainList = [WaterFountain(coordinate: CLLocationCoordinate2DMake(32.7344318, -117.1549204),
                                          areaPointer: 2),
                            WaterFountain(coordinate: CLLocationCoordinate2DMake(32.7356592, -117.1531206),
                                          areaPointer: 5)
        ]
        
        return fountainList
    }()
    
}
