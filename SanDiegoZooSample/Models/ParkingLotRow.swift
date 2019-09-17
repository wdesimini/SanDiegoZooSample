//
//  ParkingLotRow.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 6/12/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation


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
