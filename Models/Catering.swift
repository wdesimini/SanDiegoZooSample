//
//  Catering.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/21/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import CoreLocation


class Catering: ZooObject {
    
    init(name: String, coordinate: CLLocationCoordinate2D, imageString: String?, areaPointer: Int, summary: String?) {
        super.init(name: name, coordinate: coordinate, imageString: imageString, areaPointer: areaPointer, type: .catering, summary: summary)
    }
    
}
