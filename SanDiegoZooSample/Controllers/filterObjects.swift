//
//  filterObjects.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/18/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation
import MapKit


extension MapViewController {
    
    func filterObjects() {
        if (areaFilter != nil && areaFilter != .unknown) {
            let filteredObjects = currentObjects.filter { $0.area == areaFilter }
            currentObjects = filteredObjects
        }
        
        if (typeFilter != nil && typeFilter != .unknown) {
            let filteredObjects = currentObjects.filter { $0.type == typeFilter }
            currentObjects = filteredObjects
            
        }
    }
    
    // selected area filtering
    
    @objc func filterForSelectedArea(_ notification: NSNotification) {
        guard let area = notification.object as? ZooArea else { return }
        
        areaFilter = area
        
        // set button appearance
        setAreaFilterButtonAppearance(area: area)
        
        // add annotations
        loadZooObjectData()
        addAnnotations()
        showAnnotationsOnMap()
        tableView.reloadData()
        
        guard area != .unknown else {
            // .unknown removes filter, just use all
            mapView.region = initialMapRegion
            return
        }
        
        mapView.showAnnotations(
            mapView.annotations.filter { $0 is ZooAnnotation },
            animated: false
        )
        
        // zoom out so tiles can render
        mapView.setRegion(defaultRegion, animated: true)
    }
    
    func setAreaFilterButtonAppearance(area: ZooArea) {
        
        var titleColor = UIColor()
        var title = String()
        
        if area == .unknown {
            title = "select area to filter"
            titleColor = .black
        } else {
            title = area.getAreaName()
            titleColor = .white
        }
        
        areaFilterButton.setTitle(title, for: .normal)
        areaFilterButton.setTitleColor(titleColor, for: .normal)
        areaFilterButton.backgroundColor = area.getAreaColor()
    }
}
