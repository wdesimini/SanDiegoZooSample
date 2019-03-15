//
//  DiningData.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import CoreLocation

struct DiningData {
    
    static let restaurants: [Dining] = {
        [Dining(name: "Sabertooth Grill",
                coordinate: CLLocationCoordinate2DMake(32.738059, -117.152042),
                areaPointer: 5,
                menuString: "SabertoothGrill_menu"),
         Dining(name: "Zoo Brew",
                coordinate: CLLocationCoordinate2DMake(32.735193, -117.150901),
                areaPointer: 1,
                summary: "Specialty coffee drinks and craft beer.",
                menuString: "ZooBrew_menu"),
         Dining(name: "Rocks Box",
                coordinate: CLLocationCoordinate2DMake(32.736814, -117.152146),
                areaPointer: 6,
                summary: "Hot dogs, nachos, locally brewed draft beer, ICEEs, and soft drinks.")
        ]
    }()
    
}
