//
//  Dining.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import CoreLocation

class Dining: ZooObject {
    
    var menuString: String?
    
    init(name: String, coordinate: CLLocationCoordinate2D, areaPointer: Int, summary: String? = "No Summary Found", menuString: String? = nil) {
        super.init(name: name, coordinate: coordinate, areaPointer: areaPointer, type: .dining, summary: summary)
        self.menuString = menuString
    }
}
