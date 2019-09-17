//
//  ParkingLotSign.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import CoreLocation

class ParkingLotSign: ZooObject {
    
    var lotRow: ParkingLotRow
    var column: Int
    
    init(coordinate: CLLocationCoordinate2D, lotRow: ParkingLotRow, column: Int) {
        self.lotRow = lotRow
        self.column = column
        
        super.init(
            name: "Parking Lot Sign \(String(lotRow.getRowName())) \(String(column))",
            coordinate: coordinate,
            areaPointer: 9,
            type: .parkingLotSign
        )
    }
}
