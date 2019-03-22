//
//  Shopping.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/21/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import CoreLocation


class Shopping: ZooObject {
    
    init(name: String, coordinate: CLLocationCoordinate2D, areaPointer: Int, summary: String?) {
        super.init(name: name, coordinate: coordinate, areaPointer: areaPointer, type: .shopping, summary: summary)
    }
    
}
