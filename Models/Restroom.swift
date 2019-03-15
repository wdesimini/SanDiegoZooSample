//
//  Restroom.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import CoreLocation

class Restroom: ZooObject {
    
    var restroomType: RestroomType
    
    init(coordinate: CLLocationCoordinate2D, areaPointer: Int, restroomType: RestroomType) {
        self.restroomType = restroomType
        
        super.init(name: "Restroom", coordinate: coordinate, areaPointer: areaPointer, type: .restroom)
        
        let restroomName = area.getAreaName() + "Restroom"
        self.name = restroomName
        
        let restroomSummary = "Restrooms are conveniently located all around the San Diego Zoo.\n\nFamily Restrooms are located at Sabertooth Grill, Sydney's Grill, Hua Mei Café, as well as near to Skyfari East"
        self.summary = restroomSummary
    }
}

enum RestroomType {
    case regular, family
}
