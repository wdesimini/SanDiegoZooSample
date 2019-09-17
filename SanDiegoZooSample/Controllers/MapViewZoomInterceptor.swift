//
//  MapViewZoomInterceptor.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/12/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit
import MapKit

// Set Zoom Gesture Recognizer for controllers' mapView

protocol MapViewZoomInterceptor {
    var zoomInterceptor: WildCardGestureRecognizer! { get set }
    
    func setMapViewZoomInterceptor(mapView: MKMapView)
}

extension MapViewZoomInterceptor where Self: UIViewController {
    func setMapViewZoomInterceptor(mapView: MKMapView) {
        let northernBorder = 32.741152
        let southernBorder = 32.731461
        let easternBorder = -117.143622
        let westernBorder = -117.157399
        
        var latitude  = mapView.region.center.latitude
        var longitude = mapView.region.center.longitude
        
        if (mapView.region.center.latitude > northernBorder) {
            latitude = northernBorder
        }
        
        if (mapView.region.center.latitude < southernBorder) {
            latitude = southernBorder
        }
        
        if (mapView.region.center.longitude > easternBorder) {
            longitude = easternBorder
        }
        
        if (mapView.region.center.longitude < westernBorder) {
            longitude = westernBorder
        }
        
        // started zooming
        zoomInterceptor.touchesBeganCallback = {_, _ in
            mapView.isZoomEnabled = true
        }
        
        // currently zooming
        zoomInterceptor.touchesMovedCallback = {_, _ in
            // if zooming out
            if self.zoomInterceptor.scale < 1 {
                let positionChanged = (latitude != mapView.region.center.latitude || longitude != mapView.region.center.longitude)
                let latTooBig = (mapView.region.span.latitudeDelta > (northernBorder - southernBorder))
                let longTooBig = (mapView.region.span.longitudeDelta > (easternBorder - westernBorder))
                
                // don't change zoom if don't need to
                guard positionChanged || latTooBig || longTooBig else { return }
                
                let maxSpan = MKCoordinateSpan.init(latitudeDelta: 0.007, longitudeDelta: 0.007)
                let latDeltaTooBig = mapView.region.span.latitudeDelta > maxSpan.latitudeDelta
                let longDeltaTooBig = mapView.region.span.longitudeDelta > maxSpan.longitudeDelta
                
                if latDeltaTooBig || longDeltaTooBig {
                    mapView.isZoomEnabled = false
                } else {
                    mapView.isZoomEnabled = true
                }
                // if zooming in
            } else if self.zoomInterceptor.scale > 1 {
                let minimumSpan = MKCoordinateSpan.init(latitudeDelta: 0.002, longitudeDelta: 0.002)
                let latDeltaTooSmall = mapView.region.span.latitudeDelta < minimumSpan.latitudeDelta
                let longDeltaTooSmall = mapView.region.span.longitudeDelta < minimumSpan.longitudeDelta
                
                if latDeltaTooSmall || longDeltaTooSmall {
                    mapView.isZoomEnabled = false
                } else {
                    mapView.isZoomEnabled = true
                }
            }
        }
        
        // done zooming
        zoomInterceptor.touchesEndedCallback = {_, _ in
            mapView.isZoomEnabled = true
        }
        
        mapView.addGestureRecognizer(zoomInterceptor)
    }
}
