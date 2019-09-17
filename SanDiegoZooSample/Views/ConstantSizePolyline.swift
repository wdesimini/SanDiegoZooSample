//
//  ConstantSizePolyline.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/12/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import MapKit

// Drawing Polylines that don't adjust in size with zoom

class ConstantSizePolyline: MKPolylineRenderer {
    
    var lineType: ZooLineType!
    
    override func applyStrokeProperties(to context: CGContext, atZoomScale zoomScale: MKZoomScale) {
        
        super.applyStrokeProperties(to: context, atZoomScale: zoomScale)
        UIGraphicsPushContext(context)
        
        if let ctx = UIGraphicsGetCurrentContext() {
            ctx.setLineWidth(self.lineWidth)
        }
    }
}
