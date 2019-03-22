//
//  ZooAnnotation.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/12/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import MapKit

class ZooAnnotation: NSObject, MKAnnotation {
    let object: ZooObject
    
    init(object: ZooObject) {
        self.object = object
        super.init()
    }
    
    var coordinate: CLLocationCoordinate2D {
        return object.coordinate
    }
    
    var title: String? {
        return object.name
    }
    
    var area: ZooArea? {
        return object.area
    }
    
    var markerTintColor: UIColor  {
        switch object.type {
        case .animal:
            return .yellow
        case .general:
            return .cyan
        case .dining:
            return MyColors.diningGreen
        case .shopping:
            return MyColors.shoppingRed
        case .catering:
            return MyColors.cateringOrange
        case .aviary:
            return .purple
        case .restroom:
            return .blue
        case .waterFountain:
            return .blue
        case .mapLocation:
            return .red
        default:
            return .gray
        }
    }

    var glyphText: String? {
        switch object.type {
        case .mapLocation:
            let mapLocation = object as? MapLocationSign
            
            guard let number = mapLocation?.number else { return nil }
            
            return String(number)
        case .parkingLotSign:
            let lotSign = object as? ParkingLotSign
            
            guard let columnNumber = lotSign?.column else { return nil }
            
            return String(columnNumber)
        default:
            return nil
        }
    }
}

extension ZooAnnotation {
    func getAnnotationView() -> ZooAnnotationView {
        switch object.type {
        case .animal:
            return AnimalAnnotationView(annotation: self, reuseIdentifier: AnimalAnnotationView.ReuseID)
        case .dining:
            return DiningAnnotationView(annotation: self, reuseIdentifier: DiningAnnotationView.ReuseID)
        case .shopping:
            return ShoppingAnnotationView(annotation: self, reuseIdentifier: ShoppingAnnotationView.ReuseID)
        case .catering:
            return CateringAnnotationView(annotation: self, reuseIdentifier: CateringAnnotationView.ReuseID)
        case .general:
            return GeneralAnnotationView(annotation: self, reuseIdentifier: GeneralAnnotationView.ReuseID)
        case .aviary:
            return AviaryAnnotationView(annotation: self, reuseIdentifier: AviaryAnnotationView.ReuseID)
        case .restroom:
            return RestroomAnnotationView(annotation: self, reuseIdentifier: RestroomAnnotationView.ReuseID)
        case .waterFountain:
            return WaterFountainAnnotationView(annotation: self, reuseIdentifier: WaterFountainAnnotationView.ReuseID)
        case .mapLocation:
            return MapLocationAnnotationView(annotation: self, reuseIdentifier: MapLocationAnnotationView.ReuseID)
        case .parkingLotSign:
            return ParkingLotSignAnnotationView(annotation: self, reuseIdentifier: ParkingLotSignAnnotationView.ReuseID)
        default:
            return ZooAnnotationView(annotation: self, reuseIdentifier: ZooAnnotationView.ReuseID)
        }
    }
}
