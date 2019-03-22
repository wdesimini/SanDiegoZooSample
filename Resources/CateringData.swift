//
//  CateringData.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/21/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import CoreLocation


struct CateringData {
    
    static let cateringRestaurants: [Catering] = {
        [Catering(name: "Treetops Room",
                  coordinate: CLLocationCoordinate2DMake(32.734754, -117.152142),
                  imageString: "Treetops Room",
                  areaPointer: 1,
                  summary: "This plantation-style venue captures the simplicity and serenity of life on the plains of Africa, with floor-to-ceiling windows, a private patio with waterfall and authentic African décor."),
         Catering(name: "Rondavel Room",
                  coordinate: CLLocationCoordinate2DMake(32.735747, -117.149327),
                  imageString: "Rondavel Room",
                  areaPointer: 1,
                  summary: "This octagonal room has vaulted, beamed ceilings and rich earth-tones, with floor-to-ceiling picture windows overlooking an ornamental Asian garden complete with a koi pond and exotic waterfowl.")
        ]
    }()
    
}
