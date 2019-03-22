//
//  ParkingLotSignData.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import CoreLocation


struct ParkingLotSignData {
    
    lazy var signs: [ParkingLotSign] = {
        
        let signsList = [ParkingLotSign(coordinate: CLLocationCoordinate2DMake(32.735716, -117.148594),
                                        lotRow: .panda,
                                        column: 1),
                         ParkingLotSign(coordinate: CLLocationCoordinate2DMake(32.7357218, -117.1478205),
                                        lotRow: .panda,
                                        column: 2),
                         ParkingLotSign(coordinate: CLLocationCoordinate2DMake(32.736009, -117.148721),
                                        lotRow: .parrot,
                                        column: 1),
                         ParkingLotSign(coordinate: CLLocationCoordinate2DMake(32.7360242, -117.1478259),
                                        lotRow: .parrot,
                                        column: 2)
        ]
        
        return signsList
        
    }()
    
}
