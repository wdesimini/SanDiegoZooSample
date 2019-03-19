//
//  WaterFountain.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import CoreLocation

private let waterFountainSummary = "Water Fountain locations can be found spread out across all areas of the San Diego Zoo."

class WaterFountain: ZooObject {
    
    init(coordinate: CLLocationCoordinate2D, areaPointer: Int) {
        super.init(name: "Water Fountain", coordinate: coordinate, areaPointer: areaPointer, type: .waterFountain)
        
        let fountainName = area.getAreaName() + " Water Fountain"
        self.name = fountainName
        
        self.summary = waterFountainSummary
    }
    
}
