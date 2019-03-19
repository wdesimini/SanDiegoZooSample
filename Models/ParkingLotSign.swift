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
        
        let lotSignName = "Parking Lot Sign \(String(lotRow.getRowName())) \(String(column))"
        
        super.init(name: lotSignName, coordinate: coordinate, areaPointer: 9, type: .parkingLotSign)
    }
}

enum ParkingLotRow {
    case panda, parrot, meerkat, hornbill, koala, flamingo, giraffe, orangutan, frog
}

extension ParkingLotRow {
    
    func getRowName() -> String {
        switch self {
        case .panda:
            return "Panda"
        case .parrot:
            return "Parrot"
        case .meerkat:
            return "Meerkat"
        case .hornbill:
            return "Hornbill"
        case .koala:
            return "Koala"
        case .flamingo:
            return "Flamingo"
        case .giraffe:
            return "Giraffe"
        case .orangutan:
            return "Orangutan"
        case .frog:
            return "Frog"
        }
    }
    
}
