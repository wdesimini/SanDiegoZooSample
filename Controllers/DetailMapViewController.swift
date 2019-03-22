//
//  DetailMapViewController.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/22/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailMapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var object: ZooObject!
    
    let zoo = Zoo(name: "San Diego Zoo")
    
    var zooAnnotations = [ZooAnnotation]()
    
    var tileRenderer: MKTileOverlayRenderer!
    var zoomInterceptor: WildCardGestureRecognizer!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLocationManager()
        setInitialRegion()
        setTileRenderer()
        setZoomGestureRecognizer()
        drawPolylines()
        addAnnotations()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // remove memory allocations
        zoomInterceptor = nil
        mapView.gestureRecognizers = nil
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
    }
    
    func setLocationManager() {
        
        guard CLLocationManager.locationServicesEnabled() else {
            print("location isn't authorized yet")
            return
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
    }
    
    func setInitialRegion() {
        let perimeter = zoo.perimeter
        let latDelta = perimeter.overlayTopLeftCoordinate.latitude - perimeter.overlayBottomRightCoordinate.latitude
        let span = MKCoordinateSpan.init(latitudeDelta: fabs(latDelta), longitudeDelta: 0.0)
        let region = MKCoordinateRegion.init(center: perimeter.midCoordinate, span: span)
        
        mapView.region = region
    }
    
    func setTileRenderer() {
        let overlay = ZooOverlay()
        
        tileRenderer = MKTileOverlayRenderer(tileOverlay: overlay)
        overlay.canReplaceMapContent = true
        mapView.addOverlay(overlay, level: .aboveLabels)
        
        overlay.minimumZ = 17
        overlay.maximumZ = 19
    }
    
    func drawPolylines() {
        addRoutes()
        addParkingLotGrid("ParkingLotGrid")
    }
    
    func addRoutes() {
        Routes.inParkStreets.forEach {
            addRoute($0, lineType: .ips)
        }
        
        Routes.trails.forEach {
            addRoute($0, lineType: .trail)
        }
        
        Routes.transportPaths.forEach {
            addRoute($0, lineType: .transport)
        }
        
        Routes.roads.forEach {
            addRoute($0, lineType: .road)
        }
    }
    
    func addRoute(_ routeName: String, lineType: ZooLineType) {
        guard let points = Zoo.plist(routeName) as? [String] else { return }
        let cgPoints = points.map { NSCoder.cgPoint(for: $0) }
        let coords = cgPoints.map { CLLocationCoordinate2DMake(CLLocationDegrees($0.x), CLLocationDegrees($0.y)) }
        let myPolyline = ZooPolyline(coordinates: coords, count: coords.count)
        
        myPolyline.title = routeName
        myPolyline.lineType = lineType
        
        mapView.addOverlay(myPolyline)
    }
    
    func addParkingLotGrid(_ gridName: String) {
        guard let gridFile = Zoo.plist(gridName) as? [String : Any] else { return }
        
        let column1dict: [String: Any] = gridFile["Column 1"] as! [String : Any]
        let column2dict: [String: Any] = gridFile["Column 2"] as! [String : Any]
        
        let dictArray: [[String: Any]] = [column1dict, column2dict]
        
        dictArray.forEach { addLotByColumn($0) }
    }
    
    func addLotByColumn(_ dict: [String : Any]) {
        for (key,_) in dict {
            guard let linePoints = dict[key] as? [String] else { return }
            
            let cgPoints = linePoints.map { NSCoder.cgPoint(for: $0) }
            let coords = cgPoints.map { CLLocationCoordinate2DMake(CLLocationDegrees($0.x), CLLocationDegrees($0.y)) }
            let myGridline = ZooPolyline(coordinates: coords, count: coords.count)
            myGridline.title = key
            myGridline.lineType = .parkingLotRow
            
            mapView.addOverlay(myGridline)
        }
    }
    
    func addAnnotations() {
        
        // register Annotations
        let reuseId = MKMapViewDefaultAnnotationViewReuseIdentifier
        mapView.register(ZooAnnotationView.self, forAnnotationViewWithReuseIdentifier: reuseId)
        
        // add annotation to annotations list
        let annotation = ZooAnnotation(object: object)
        zooAnnotations.append(annotation)
        
        // if animal and more than one location
        if let animalObject = object as? Animal,
            animalObject.alternateLocations != nil {
            
            // add annotations for all coordinates
            addMultipleLocationAnnotation(animal: animalObject)
        }
        
        zooAnnotations.forEach {
            mapView.addAnnotation($0)
        }
    }
    
    func addMultipleLocationAnnotation(animal: Animal) {
        
        // iterate through each alternate location and add annotation for each
        animal.alternateLocations!.forEach {
            
            let alterLocationAnimal = Animal(name: animal.name,
                                             coordinate: $0.coordinate,
                                             imageString: animal.imageString,
                                             areaPointer: $0.areaPointer,
                                             conservationStatus: animal.conservationStatus,
                                             summary: animal.summary)
            
            zooAnnotations.append(ZooAnnotation(object: alterLocationAnimal))
        }
        
    }
}

extension DetailMapViewController: MapViewZoomInterceptor {
    
    func setZoomGestureRecognizer() {
        zoomInterceptor = WildCardGestureRecognizer(target: nil, action: nil)
        setMapViewZoomInterceptor(mapView: mapView)
    }
    
}

extension DetailMapViewController: MKMapViewDelegate {
    
    // Overlays
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        switch overlay {
        case is ZooOverlay:
            return tileRenderer
        case is MKPolyline:
            guard let zooPolyline = overlay as? ZooPolyline else {
                return MKOverlayRenderer()
            }
            
            return zooPolyline.getPolylineRenderer()
        default:
            return MKOverlayRenderer()
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? ZooAnnotation else { return nil }
        
        return annotation.getAnnotationView()
    }
    
    // Showing details for selected callouts
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        navigationController?.popViewController(animated: true)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        restrictMapViewToRegion(mapView: mapView)
    }
}
