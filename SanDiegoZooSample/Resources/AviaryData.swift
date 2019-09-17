//
//  AviaryData.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/21/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import CoreLocation


struct AviaryData {
    
    lazy var aviaries: [ZooObject] = {
        
        let aviaryList = [
            ZooObject(name: "Marsh Aviary",
                      coordinate: CLLocationCoordinate2DMake(32.734714, -117.154950),
                      areaPointer: 2,
                      type: .aviary,
                      summary: "Home to the diving ducks including buffleheads, harlequin ducks, redheads, smews, wigeons, pintails, canvasbacks, and long-tailed ducks. The aviary houses more than 25 species of duck. Some of the horticultural highlights include giant redwood trees, many different pine trees, and manzanita."),
            ZooObject(name: "Parker Aviary",
                      coordinate: CLLocationCoordinate2DMake(32.735158, -117.151111),
                      areaPointer: 1,
                      type: .aviary,
                      summary: "It’s no secret that the San Diego Zoo is home to world-class botanical gardens, thriving mixed-species exhibits, and a fascinating array of nonhuman primates. Nowhere is this trifecta of biodiversity more astonishing than in Parker Aviary, located just past the orangutans. Last spring, a pair of golden lion tamarins, Penny and Milo, were added to the lushly forested aviary. “It’s the only place in the Zoo where guests can be in the exhibit with the primates,” said lead keeper Janice McNernie. The puppy-sized monkeys bring feisty, fast, orange action to the immersive experience, dashing through the treetops, scampering across vines over the walkway, and perching on branches…and sometimes even pausing on their species identification sign! Between the shimmering, auburn-haired tamarins, the carrot orange plumage of the Andean cock-of-the-rock birds, and the flamboyant bills of the toco toucans, guests will delight in the vibrant flashes of color against the emerald foliage.")
        ]
        
        return aviaryList
        
    }()
    
}
