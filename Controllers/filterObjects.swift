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
            setInitialRegion()
            
            return
        }
        
        let zooAnnotations = mapView.annotations.filter { !($0 is MKUserLocation) }
        
        mapView.showAnnotations(zooAnnotations, animated: false)
        
        // zoom out so tiles can render
        let span = MKCoordinateSpan.init(latitudeDelta: 0.007, longitudeDelta: 0.0)
        let region = MKCoordinateRegion.init(center: mapView.centerCoordinate, span: span)
        mapView.setRegion(region, animated: true)
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
    
    // selected type filtering
    
    @objc func typeFilterButtonTapped() {
        typeDropDown.show()
    }
    
    func setTypeDropDown() {
        // add button as titleView
        navigationItem.titleView = typeFilterButton
        typeFilterButton.addTarget(self, action: #selector(typeFilterButtonTapped), for: .touchUpInside)
        
        typeDropDown.anchorView = navigationController?.navigationBar
        typeDropDown.cellHeight = 50
        typeDropDown.direction = .bottom
        typeDropDown.bottomOffset = CGPoint(x: 0, y: typeDropDown.anchorView!.plainView.bounds.height)
        typeDropDown.backgroundColor = .white
        typeDropDown.selectionBackgroundColor = .lightGray
        typeDropDown.textColor = .black
        typeDropDown.cornerRadius = 10
        
        typeDropDown.dataSource = [
            "Animals",
            "Dining",
            "Shopping",
            "Catering",
            "Aviaries",
            "Map Locations",
            "Parking Lot Signs",
            "General",
            "Water Fountains",
            "Restrooms",
            "No Filter"
        ]
        
        typeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.typeFilter = ZooObjectType(rawValue: index)
            self.typeFilterButton.setTitle(item, for: .normal)
            self.typeDropDown.hide()
        }
        
    }
}
