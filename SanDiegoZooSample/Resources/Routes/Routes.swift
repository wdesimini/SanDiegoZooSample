//
//  Routes.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/13/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import MapKit


struct Routes {
    
    static let trails: [String] = [
        "FernCanyon_Trail",
        "SunBear_Trail",
        "Monkey_Trail",
        "Reptiles_Trail",
        "UrbanJungle_Trail",
        "AfricaRocks_Trail",
        "ElephantOdyssey_Trail",
        "OwensAviary_Trail",
        "Orangutan_Trail",
        "ParkerAviary_Trail",
        "Tiger_Trail",
        "Hippo_Trail",
        "Panda_Trail",
        "NorthernFrontier_Trail",
        "ChildrenZoo_Trail",
        "AsianLeopards_Trail",
        "TerraceLagoon_Trail",
        
        // Temporary filler trails
        "Tazmanian_Trail",
        "KoalaCenter_Trail",
        "SouthofAlberts_Trail",
        "OwensFiller_Trail",
        "AlbertHippoConnection_Trail",
        "Connection_Gorilla_Monkey_Trail",
        "MonkeyHippoConnection_Trail",
        "AfricanWaterfall_Trail",
        "BusLoadingPath_Trail"
    ]
    
    static let inParkStreets: [String] = [
        "FrontStreet_IPS",
        "TreetopsWay_IPS",
        "ParkWay_IPS",
        "CenterStreet_IPS"
    ]
    
    static let transportPaths: [String] = [
        "BashorBridge_Transport",
        "Skyline_Transport",
        "AviaryEscalator_Transport"
    ]
    
    static let roads: [String] = [
        "ZooDrive_Road",
        "ZooPlace_Road"
    ]
    
    static let routesArray: [String] = [
        // Trails
        "FernCanyon_Trail",
        "SunBear_Trail",
        "Monkey_Trail",
        "Reptiles_Trail",
        "UrbanJungle_Trail",
        "AfricaRocks_Trail",
        "ElephantOdyssey_Trail",
        "OwensAviary_Trail",
        "Orangutan_Trail",
        "ParkerAviary_Trail",
        "Tiger_Trail",
        "Hippo_Trail",
        "Panda_Trail",
        "NorthernFrontier_Trail",
        "ChildrenZoo_Trail",
        "AsianLeopards_Trail",
        "TerraceLagoon_Trail",
        
        // Temporary filler trails
        "Tazmanian_Trail",
        "KoalaCenter_Trail",
        "SouthofAlberts_Trail",
        "OwensFiller_Trail",
        "AlbertHippoConnection_Trail",
        "Connection_Gorilla_Monkey_Trail",
        "MonkeyHippoConnection_Trail",
        "AfricanWaterfall_Trail",
        "BusLoadingPath_Trail",
        
        // In-Park Streets
        "FrontStreet_IPS",
        "TreetopsWay_IPS",
        "ParkWay_IPS",
        "CenterStreet_IPS",
        
        // Transport
        "BashorBridge_Transport",
        "Skyline_Transport",
        "AviaryEscalator_Transport",
        
        // Roads
        "ZooDrive_Road",
        "ZooPlace_Road"
    ]
    
    static let allPolylines: [MKPolyline] =
        inParkStreetPolylines
            + trailPolylines
            + transportPathPolylines
            + roadPolylines
            + parkingLotGrid
    
    static let inParkStreetPolylines = Routes.inParkStreets.map { fetchRoute(from: $0, lineType: .ips) }
    static let trailPolylines = Routes.trails.map { fetchRoute(from: $0, lineType: .trail) }
    static let transportPathPolylines = Routes.transportPaths.map { fetchRoute(from: $0, lineType: .transport) }
    static let roadPolylines = Routes.roads.map { fetchRoute(from: $0, lineType: .road) }
    
    static func fetchRoute(from name: String, lineType: ZooLineType) -> MKPolyline {
        let points = Zoo.plist(name) as! [String]
        let cgPoints = points.map { NSCoder.cgPoint(for: $0) }
        let coords = cgPoints.map { $0.coordinate }
        let myPolyline = ZooPolyline(coordinates: coords, count: coords.count)
        myPolyline.title = name
        myPolyline.lineType = lineType
        return myPolyline
    }
    
    static let parkingLotGrid: [MKPolyline] = {
        let gridFile = Zoo.plist("ParkingLotGrid") as! [String : Any]
        let column1dict: [String: Any] = gridFile["Column 1"] as! [String : Any]
        let column2dict: [String: Any] = gridFile["Column 2"] as! [String : Any]
        let dictArray: [[String: Any]] = [column1dict, column2dict]
        
        func getGridline(_ dict: [String : Any]) -> [MKPolyline] {
            return dict.map {
                let linePoints = $0.value as! [String]
                let cgPoints = linePoints.map { NSCoder.cgPoint(for: $0) }
                let coords = cgPoints.map { $0.coordinate }
                let myGridline = ZooPolyline(coordinates: coords, count: coords.count)
                myGridline.title = $0.key
                myGridline.lineType = .parkingLotRow
                return myGridline
            }
        }
        
        return dictArray.flatMap { getGridline($0) }
    }()
    
    
}
