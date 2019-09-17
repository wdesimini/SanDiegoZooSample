//
//  ZooPerimeter.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 6/12/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation
import CoreLocation


struct ZooPerimeter {
    
    var midCoordinate = CLLocationCoordinate2D()
    var overlayTopLeftCoordinate = CLLocationCoordinate2D()
    var overlayTopRightCoordinate = CLLocationCoordinate2D()
    var overlayBottomLeftCoordinate = CLLocationCoordinate2D()
    
    var overlayBottomRightCoordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(
            overlayBottomLeftCoordinate.latitude,
            overlayTopRightCoordinate.longitude
        )
    }
    
}
