//
//  Zoo.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit
import MapKit

class Zoo: NSObject {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    let perimeter = ZooPerimeter(midCoordinate: CLLocationCoordinate2DMake(32.7366, -117.1517),
                                 overlayTopLeftCoordinate: CLLocationCoordinate2DMake(32.7404, -117.1579),
                                 overlayTopRightCoordinate: CLLocationCoordinate2DMake(32.7404, -117.1451),
                                 overlayBottomLeftCoordinate: CLLocationCoordinate2DMake(32.7321, -117.1579))
    
    class func plist(_ plist: String) -> Any? {
        let filePath = Bundle.main.path(forResource: plist, ofType: "plist")!
        let data = FileManager.default.contents(atPath: filePath)!
        
        return try! PropertyListSerialization.propertyList(from: data, options: [], format: nil)
    }
    
    static func parseCoord(dict: [String: Any], fieldName: String) -> CLLocationCoordinate2D {
        guard let coord = dict[fieldName] as? String else {
            return CLLocationCoordinate2D()
        }
        
        let point = NSCoder.cgPoint(for: coord)
        
        return CLLocationCoordinate2DMake(CLLocationDegrees(point.x), CLLocationDegrees(point.y))
    }
    
    // objects
    let animals = AnimalData.animals
    let restaurants = DiningData.restaurants
    let restrooms = RestroomData.restrooms
    let waterFountains = WaterFountainData.waterFountains
    let mapLocations = MapLocationData.mapLocations
    let parkingLotSigns = ParkingLotSignData.signs
    
    // experiences
    let specialExperiencesArray = ZooExperiences.specialExperiences
    let zooEducationArray = ZooExperiences.zooEducations
    let activitiesArray = ZooExperiences.activities
    let animalEncountersArray = ZooExperiences.animalEncounters
    let showsArray = ZooExperiences.shows
    let playAreasArray = ZooExperiences.playAreas
}

struct ZooPerimeter {
    
    var midCoordinate = CLLocationCoordinate2D()
    var overlayTopLeftCoordinate = CLLocationCoordinate2D()
    var overlayTopRightCoordinate = CLLocationCoordinate2D()
    var overlayBottomLeftCoordinate = CLLocationCoordinate2D()
    var overlayBottomRightCoordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2DMake(overlayBottomLeftCoordinate.latitude,
                                              overlayTopRightCoordinate.longitude)
        }
    }
    
}
