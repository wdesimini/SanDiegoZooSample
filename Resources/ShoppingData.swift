//
//  ShoppingData.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/21/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation
import CoreLocation


struct ShoppingData {
    
    static let shoppingAreas: [Shopping] = {
        [Shopping(name: "Panda Shop",
                  coordinate: CLLocationCoordinate2DMake(32.735572, -117.151972),
                  areaPointer: 4,
                  summary: "All things panda—and MORE!")
        ]
    }()
    
    
}

