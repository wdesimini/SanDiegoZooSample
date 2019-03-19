//
//  MapViewController.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit
import MapKit
import DropDown

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var areaFilterButton: UIButton!
    @IBOutlet weak var showButton: UIBarButtonItem!
    
    let zoo = Zoo(name: "San Diego Zoo")
    
    var zooAnnotations = [ZooAnnotation]()
    
    var tileRenderer: MKTileOverlayRenderer!
    var zoomInterceptor: WildCardGestureRecognizer!
    
    var currentObjects = [ZooObject]()
    var areaFilter: ZooArea?
    var typeFilter: ZooObjectType? {
        didSet {
            loadZooObjectData()
            addAnnotations()
            showAnnotationsOnMap()
            tableView.reloadData()
        }
    }
    
    let typeFilterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame.size = CGSize(width: 100, height: 44)
        button.setTitle("type filter", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    let typeDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitialRegion()
        setTileRenderer()
        setZoomGestureRecognizer()
        drawPolylines()
        loadZooObjectData()
        
        let reuseId = MKMapViewDefaultAnnotationViewReuseIdentifier
        mapView.register(ZooAnnotationView.self, forAnnotationViewWithReuseIdentifier: reuseId)
        
        addAnnotations()
        showAnnotationsOnMap()
        setTypeDropDown()
        addNotificationObserver()
    }
    
    func addNotificationObserver() {
        let selector = #selector(self.filterForSelectedArea(_:))
        let name = NSNotification.Name(rawValue: "areaSelected")
        
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
    
    @IBAction func selectAreaFilterButtonTapped(_ sender: Any) {
        let pickerController = UINavigationController(rootViewController: PickAreaViewController())
        
        pickerController.modalPresentationStyle = .overCurrentContext
        
        present(pickerController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapToObjectDetailSegue" {
            let destVC = segue.destination as? ObjectDetailViewController
            destVC?.object = sender as? ZooObject
            destVC?.fromMap = true
        }
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
    
    func loadZooObjectData() {
        // remove previous objects
        currentObjects.removeAll()
        
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
                // add to objects list
                currentObjects.append($0)
            }
        }
        
        // filter objects if a filter exists
        if (areaFilter != nil && areaFilter != .unknown) || (typeFilter != nil && typeFilter != .unknown) {
            filterObjects()
        }
    }
    
    func addAnnotations() {
        zooAnnotations.removeAll()
        
        currentObjects.forEach {
            // add annotation to annotations list
            let annotation = ZooAnnotation(object: $0)
            zooAnnotations.append(annotation)
        }
    }
    
    func showAnnotationsOnMap() {
        mapView.removeAnnotations(mapView.annotations)
        
        zooAnnotations.forEach {
            mapView.addAnnotation($0)
        }
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        
        // remove memory allocations on pop to main tab controller
        zoomInterceptor = nil
        mapView.gestureRecognizers = nil
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        
        // remove observer
        NotificationCenter.default.removeObserver(self)
        
        // pop to tabBar controller
        dismiss(animated: true, completion: nil)
    }
    
    
    var mapShowing: Bool = true {
        didSet {
            if mapShowing {
                tableView.isHidden = true
                showButton.title = "Show List"
            } else {
                tableView.isHidden = false
                showButton.title = "Show Map"
            }
        }
    }
    
    @IBAction func showButtonTapped(_ sender: Any) {
        mapShowing = !mapShowing
    }
    
    deinit {
        print("map view controller deinit")
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
        let object = annotation?.object
        
        performSegue(withIdentifier: "mapToObjectDetailSegue", sender: object)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        restrictMapViewToRegion(mapView: mapView)
    }
}

extension MapViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mapListCell") as! ZooObjectTableViewCell
        
        let object = currentObjects[indexPath.row]
        
        cell.setCellViews(object: object)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = currentObjects[indexPath.row]
        performSegue(withIdentifier: "mapToObjectDetailSegue", sender: object)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
