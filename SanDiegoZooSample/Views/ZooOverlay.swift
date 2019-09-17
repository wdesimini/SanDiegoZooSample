//
//  ZooOverlay.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/12/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation
import MapKit

class ZooOverlay: MKTileOverlay {
    
    override func url(forTilePath path: MKTileOverlayPath) -> URL {
        
        let tilePath = Bundle.main.url(
            forResource: "\(path.y)",
            withExtension: "png",
            subdirectory: "zoo_tiles/\(path.z)/\(path.x)",
            localization: nil)
        
        guard let tile = tilePath else {
            
            return Bundle.main.url(
                forResource: "parchment",
                withExtension: "png",
                subdirectory: "zoo_tiles",
                localization: nil)!
        }
        return tile
    }
}
