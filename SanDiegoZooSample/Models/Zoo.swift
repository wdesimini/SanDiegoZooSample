//
//  Zoo.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit


class Zoo: NSObject {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    // objects
    lazy var animalData = (UIApplication.shared.delegate as! AppDelegate).animalData
    lazy var diningData = (UIApplication.shared.delegate as! AppDelegate).diningData
    lazy var shoppingData = (UIApplication.shared.delegate as! AppDelegate).shoppingData
    lazy var cateringData = (UIApplication.shared.delegate as! AppDelegate).cateringData
    lazy var generalData = (UIApplication.shared.delegate as! AppDelegate).generalData
    lazy var restroomData = (UIApplication.shared.delegate as! AppDelegate).restroomData
    lazy var waterFountainData = (UIApplication.shared.delegate as! AppDelegate).waterFountainData
    lazy var aviaryData = (UIApplication.shared.delegate as! AppDelegate).aviaryData
    lazy var mapLocationData = (UIApplication.shared.delegate as! AppDelegate).mapLocationData
    lazy var parkingLotSignData = (UIApplication.shared.delegate as! AppDelegate).parkingLotSignData
    
    lazy var animalDataSource = animalData.animals
    lazy var diningDataSource = diningData.restaurants
    lazy var shoppingDataSource = shoppingData.shoppingAreas
    lazy var cateringDataSource = cateringData.cateringRestaurants
    lazy var generalDataSource = generalData.generalAreas
    lazy var restroomDataSource = restroomData.restrooms
    lazy var waterFountainDataSource = waterFountainData.waterFountains
    lazy var aviaryDataSource = aviaryData.aviaries
    lazy var mapLocationDataSource = mapLocationData.mapLocations
    lazy var parkingLotSignDataSource = parkingLotSignData.signs
    
    lazy var allObjectArrays: [[ZooObject]] = [
        animalDataSource,
        aviaryDataSource,
        diningDataSource,
        cateringDataSource,
        shoppingDataSource,
        restroomDataSource,
        waterFountainDataSource,
        mapLocationDataSource,
        parkingLotSignDataSource,
        generalDataSource
    ]
    
    // experiences
    let specialExperiencesArray = ZooExperiences.specialExperiences
    let zooEducationArray = ZooExperiences.zooEducations
    let activitiesArray = ZooExperiences.activities
    let animalEncountersArray = ZooExperiences.animalEncounters
    let showsArray = ZooExperiences.shows
    let playAreasArray = ZooExperiences.playAreas
}
