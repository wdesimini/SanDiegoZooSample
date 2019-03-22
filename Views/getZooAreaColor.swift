//
//  getZooAreaColor.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/18/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit

// get zoo area color

extension ZooArea {
    
    func getAreaColor() -> UIColor {
        switch self {
        case .discoveryOutpost:
            return MyColors.discoveryOutpostRed
        case .lostForest:
            return MyColors.lostForestGreen
        case .northernFrontier:
            return MyColors.northernFrontierBlue
        case .pandaCanyon:
            return MyColors.pandaCanyonRed
        case .asianPassage:
            return MyColors.asianPassagePurple
        case .elephantOdyssey:
            return MyColors.elephantOdysseyBrown
        case .africaRocks:
            return MyColors.africaRocksGreen
        case .urbanJungle:
            return MyColors.urbanJungleOrange
        case .outback:
            return MyColors.outbackPurple
        case .parkingLot:
            return .gray
        case .unknown:
            return .white
        }
    }
    
}
