//
//  ZooArea.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation
import UIKit

enum ZooArea: Int {
    case discoveryOutpost = 0, lostForest, northernFrontier, pandaCanyon, asianPassage, elephantOdyssey, africaRocks, urbanJungle, outback, parkingLot, unknown
}

extension ZooArea {
    
    // get zoo area name
    func getAreaName() -> String {
        switch self {
        case .africaRocks:
            return "Africa Rocks"
        case .asianPassage:
            return "Asian Passage"
        case .discoveryOutpost:
            return "Discovery Outpost"
        case .elephantOdyssey:
            return "Elephant Odyssey"
        case .lostForest:
            return "Lost Forest"
        case .northernFrontier:
            return "Northern Frontier"
        case .outback:
            return "Outback"
        case .pandaCanyon:
            return "Panda Canyon"
        case .parkingLot:
            return "Parking Lot"
        case .urbanJungle:
            return "Urban Jungle"
        case .unknown:
            return "Area Unknown"
        }
    }
}
