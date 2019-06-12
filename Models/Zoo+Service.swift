//
//  Zoo+Service.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 6/12/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import CoreLocation


extension Zoo {
    
    var perimeter: ZooPerimeter {
        return ZooPerimeter(
            midCoordinate: CLLocationCoordinate2DMake(32.7366, -117.1517),
            overlayTopLeftCoordinate: CLLocationCoordinate2DMake(32.7404, -117.1579),
            overlayTopRightCoordinate: CLLocationCoordinate2DMake(32.7404, -117.1451),
            overlayBottomLeftCoordinate: CLLocationCoordinate2DMake(32.7321, -117.1579)
        )
    }
    
    class func plist(_ plist: String) -> Any? {
        let filePath = Bundle.main.path(forResource: plist, ofType: "plist")!
        let data = FileManager.default.contents(atPath: filePath)!
        
        return try! PropertyListSerialization.propertyList(from: data, options: [], format: nil)
    }
    
    static func parseCoord(dict: [String: Any], fieldName: String) -> CLLocationCoordinate2D {
        guard let coord = dict[fieldName] as? String else {
            return CLLocationCoordinate2D()
        }
        
        let point = NSCoder.cgPoint(for: coord)
        
        return CLLocationCoordinate2DMake(CLLocationDegrees(point.x), CLLocationDegrees(point.y))
    }
    
}
