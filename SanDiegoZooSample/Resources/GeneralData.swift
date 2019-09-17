//
//  GeneralData.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/21/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import CoreLocation


struct GeneralData {
    
    lazy var generalAreas: [ZooObject] = {
        
        let generalList = [
            ZooObject(name: "Wegeforth Bowl",
                      coordinate: CLLocationCoordinate2DMake(32.7337324, -117.1497427),
                      areaPointer: 0,
                      type: .general,
                      summary: "Named in honor of the Zoo’s founder, Dr. Harry Wegeforth, this stadium has been the place for shows starring sea lions and many other types of animal ambassadors since the 1970s."),
            ZooObject(name: "Zoo Entrance",
                      coordinate: CLLocationCoordinate2DMake(32.7354268, -117.1493276),
                      areaPointer: 1,
                      type: .general,
                      summary: "The entrance to the San Diego Zoo."),
            ZooObject(name: "Zoo Exit",
                      coordinate: CLLocationCoordinate2DMake(32.7346994, -117.1492310),
                      areaPointer: 1,
                      type: .general,
                      summary: "The San Diego Zoo exit is located just south of the entrance")
        ]
        
        return generalList
        
    }()
    
}
