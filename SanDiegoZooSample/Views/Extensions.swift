//
//  Extensions.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/15/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit
import MapKit

extension UIImageView {
    
    func circleMask() {
        layer.borderWidth = 2
        layer.masksToBounds = false
        layer.borderColor = MyColors.darkGreen.cgColor
        layer.cornerRadius = frame.height/2
        clipsToBounds = true
    }
}

// make navigation bar translucent

extension UINavigationBar {
    
    func makeTranslucent() {
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = true
    }
}

// Restricts user from going outside of a mapView

extension UIViewController {
    
    func restrictMapViewToRegion(mapView: MKMapView) {
        let northernBorder = 32.741152
        let southernBorder = 32.731461
        let easternBorder = -117.143622
        let westernBorder = -117.157399
        
        var latitude  = mapView.region.center.latitude
        var longitude = mapView.region.center.longitude
        
        if mapView.region.center.latitude > northernBorder {
            latitude = northernBorder
        }
        
        if mapView.region.center.latitude <  southernBorder {
            latitude = southernBorder
        }
        
        if mapView.region.center.longitude > easternBorder {
            longitude = easternBorder
        }
        
        if mapView.region.center.longitude < westernBorder {
            longitude = westernBorder
        }
        
        if (latitude != mapView.region.center.latitude || longitude != mapView.region.center.longitude)
            || ((mapView.region.span.latitudeDelta > (northernBorder - southernBorder) )
                || (mapView.region.span.longitudeDelta > (easternBorder - westernBorder))) {
            var setSpan: MKCoordinateSpan
            var center = CLLocationCoordinate2D()
            center.latitude  = latitude
            center.longitude = longitude
            let span = MKCoordinateSpan.init(latitudeDelta: 0.007, longitudeDelta: 0.007)
            
            if mapView.region.span.latitudeDelta > span.latitudeDelta
                || mapView.region.span.longitudeDelta > span.longitudeDelta {
                setSpan = span
            } else {
                setSpan = mapView.region.span
            }
            
            let resetRegion:MKCoordinateRegion = MKCoordinateRegion.init(center: center, span: setSpan)
            mapView.setRegion(resetRegion, animated: true)
        }
    }
}
