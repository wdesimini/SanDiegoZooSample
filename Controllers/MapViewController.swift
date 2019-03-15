//
//  MapViewController.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    let zoo = Zoo(name: "San Diego Zoo")
    
    var zooAnnotations = [ZooAnnotation]()
    
    var tileRenderer: MKTileOverlayRenderer!
    var zoomInterceptor: WildCardGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitialRegion()
        setTileRenderer()
        setZoomGestureRecognizer()
        drawPolylines()
        addAnnotations()
        showAnnotationsOnMap()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        // remove memory allocations on dismiss
        zoomInterceptor = nil
        mapView.gestureRecognizers = nil
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
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
        let reuseId = MKMapViewDefaultAnnotationViewReuseIdentifier
        mapView.register(ZooAnnotationView.self, forAnnotationViewWithReuseIdentifier: reuseId)
        
        // object arrays
        let objectArrays: [[ZooObject]] = [
            zoo.animals,
            zoo.restaurants,
            zoo.restrooms,
            zoo.waterFountains,
            zoo.mapLocations,
            zoo.parkingLotSigns
        ]
        
        for array in objectArrays {
            array.forEach {
                let annotation = ZooAnnotation(object: $0)
                zooAnnotations.append(annotation)
            }
        }
    }
    
    func showAnnotationsOnMap() {
        zooAnnotations.forEach {
            mapView.addAnnotation($0)
        }
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("MapViewController deinit")
    }
}

extension MapViewController: MapViewZoomInterceptor {
    
    func setZoomGestureRecognizer() {
        zoomInterceptor = WildCardGestureRecognizer(target: nil, action: nil)
        setMapViewZoomInterceptor(mapView: mapView)
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
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
        let annotation = view.annotation as? ZooAnnotation
        performSegue(withIdentifier: "mapCallOutPresentSegue", sender: annotation)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        restrictMapViewToRegion(mapView: mapView)
    }
}

// Restricts user from going outside of the mapView

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
