//
//  ZooAnnotationView.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/12/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import MapKit

class ZooAnnotationView: MKMarkerAnnotationView {
    
    static let ReuseID = "ZooAnnotation"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var annotation: MKAnnotation? {
        willSet {
            displayPriority = .required
        }
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        canShowCallout = true
        rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
    }
}

class AnimalAnnotationView: ZooAnnotationView {
    override func prepareForDisplay() {
        super.prepareForDisplay()
        markerTintColor = .yellow
        let extractedExpr = #imageLiteral(resourceName: "Animal Glyph")
        glyphImage = extractedExpr
        leftCalloutAccessoryView = UIImageView(image: UIImage(named: "Gator"))
    }
}

class DiningAnnotationView: ZooAnnotationView {
    override func prepareForDisplay() {
        super.prepareForDisplay()
        markerTintColor = MyColors.diningGreen
        glyphImage = #imageLiteral(resourceName: "Dining Glyph")
    }
}

class ShoppingAnnotationView: ZooAnnotationView {
    override func prepareForDisplay() {
        super.prepareForDisplay()
        markerTintColor = MyColors.shoppingRed
        glyphImage = #imageLiteral(resourceName: "Shopping Glyph")
    }
}

class CateringAnnotationView: ZooAnnotationView {
    override func prepareForDisplay() {
        super.prepareForDisplay()
        markerTintColor = MyColors.cateringOrange
        glyphImage = #imageLiteral(resourceName: "Dining Glyph")
    }
}

class GeneralAnnotationView: ZooAnnotationView {
    override func prepareForDisplay() {
        super.prepareForDisplay()
        markerTintColor = MyColors.generalPurple
        glyphImage = #imageLiteral(resourceName: "G&A Glyph")
    }
}

class AviaryAnnotationView: ZooAnnotationView {
    override func prepareForDisplay() {
        super.prepareForDisplay()
        markerTintColor = .purple
        glyphImage = #imageLiteral(resourceName: "Aviary Glyph")
    }
}

class WaterFountainAnnotationView: ZooAnnotationView {
    override func prepareForDisplay() {
        super.prepareForDisplay()
        titleVisibility = .hidden
        markerTintColor = .blue
        glyphImage = #imageLiteral(resourceName: "Water Fountain Glyph")
    }
}

class RestroomAnnotationView: ZooAnnotationView {
    override func prepareForDisplay() {
        super.prepareForDisplay()
        titleVisibility = .hidden
        markerTintColor = .blue
        glyphImage = #imageLiteral(resourceName: "Restroom Glyph")
    }
}

class MapLocationAnnotationView: ZooAnnotationView {
    override func prepareForDisplay() {
        super.prepareForDisplay()
        canShowCallout = false
        titleVisibility = .hidden
        markerTintColor = .red
        let zooAnnotation = annotation as? ZooAnnotation
        glyphText = zooAnnotation?.glyphText
    }
}

class ParkingLotSignAnnotationView: ZooAnnotationView {
    override func prepareForDisplay() {
        super.prepareForDisplay()
        titleVisibility = .hidden
        markerTintColor = .black
        let zooAnnotation = annotation as? ZooAnnotation
        glyphText = zooAnnotation?.glyphText
    }
}

