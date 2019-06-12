//
//  Animal.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import CoreLocation


class Animal: ZooObject {
    
    var conservationStatus: ConservationStatus
    var alternateLocations: [Location]?
    
    init(
        name: String,
        coordinate: CLLocationCoordinate2D,
        imageString: String? = nil,
        areaPointer: Int,
        conservationStatus: ConservationStatus,
        summary: String? = "No Summary Found",
        alternateLocations: [Location]? = nil
        ) {
        
        self.conservationStatus = conservationStatus
        
        super.init(
            name: name,
            coordinate: coordinate,
            imageString: imageString,
            areaPointer: areaPointer,
            type: .animal,
            summary: summary
        )
        
        self.alternateLocations = alternateLocations
    }
}

struct Location {
    
    var coordinate: CLLocationCoordinate2D
    var areaPointer: Int
    
    init(coordinate: CLLocationCoordinate2D, areaPointer: Int) {
        self.coordinate = coordinate
        self.areaPointer = areaPointer
    }
    
}
