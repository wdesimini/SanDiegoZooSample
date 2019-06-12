//
//  ConservationStatus.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 6/12/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation


enum ConservationStatus {
    case endangered, threatened, stable
}

extension ConservationStatus {
    
    func getString() -> String {
        switch self {
        case .endangered:
            return "Endangered"
        case .stable:
            return "Stable"
        case .threatened:
            return "Threatened"
        }
    }
}
