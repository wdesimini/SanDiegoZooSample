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
            return .red
        case .lostForest:
            return .green
        case .northernFrontier:
            return .blue
        case .pandaCanyon:
            return .brown
        case .asianPassage:
            return .purple
        case .elephantOdyssey:
            return .brown
        case .africaRocks:
            return .green
        case .urbanJungle:
            return .orange
        case .outback:
            return .purple
        case .parkingLot:
            return .gray
        case .unknown:
            return .white
        }
    }
    
}
