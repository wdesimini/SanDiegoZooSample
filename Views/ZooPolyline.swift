//
//  ZooPolyline.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/13/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit
import MapKit

class ZooPolyline: MKPolyline {
    
    var lineType: ZooLineType!
    
}


enum ZooLineType {
    
    case ips, road, trail, transport, parkingLotRow
    
}

// Polyline renderers

extension ZooPolyline {
    
    func getPolylineRenderer() -> MKOverlayRenderer {
        let renderer = ConstantSizePolyline(overlay: self)
        // Checks what kind of path the Polyline is
        guard let type = lineType else { return MKOverlayRenderer() }
        
        var color: UIColor
        var lineWidth: CGFloat
        
        switch type {
        case .ips:
            color = UIColor.yellow
            lineWidth = 50
        case .trail:
            color = UIColor.white
            lineWidth = 10
        case .road:
            color = UIColor.white
            lineWidth = 40
        case .transport:
            color = UIColor.blue
            lineWidth = 30
        case .parkingLotRow:
            color = UIColor.white
            lineWidth = 10
        }
        
        renderer.strokeColor = color
        renderer.lineWidth = lineWidth
        renderer.lineJoin = .round
        
        return renderer
    }
    
}
