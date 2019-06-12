//
//  RestroomData.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import CoreLocation


struct RestroomData {
    
    lazy var restrooms: [Restroom] = {
        
        let restroomList = [
            Restroom(coordinate: CLLocationCoordinate2DMake(32.735743, -117.152111),
                     areaPointer: 4,
                     restroomType: .family),
            Restroom(coordinate: CLLocationCoordinate2DMake(32.734673, -117.151869),
                     areaPointer: 1,
                     restroomType: .regular),
            Restroom(coordinate: CLLocationCoordinate2DMake(32.733377, -117.148661),
                     areaPointer: 0,
                     restroomType: .regular)
        ]
        
        return restroomList
    }()
    
}
