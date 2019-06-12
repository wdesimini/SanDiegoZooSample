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
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var areaFilterButton: UIButton!
    @IBOutlet weak var showButton: UIBarButtonItem!
    
    let zoo = Zoo(name: "San Diego Zoo")
    
    private let zooOverlay: ZooOverlay = {
        let overlay = ZooOverlay()
        overlay.canReplaceMapContent = true
        overlay.minimumZ = Defaults.minimumZoom
        overlay.maximumZ = Defaults.maximumZoom
        return overlay
    }()
    
    var zoomInterceptor: WildCardGestureRecognizer!
    
    var currentObjects = [ZooObject]()
    var zooAnnotations = [ZooAnnotation]()
    
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
    
    private lazy var typeDropDown = DropDown()
    
    private func createTypeDropDown() -> DropDown {
        // add button as titleView
        let dropDown = DropDown()
        navigationItem.titleView = typeFilterButton
        typeFilterButton.addTarget(self, action: #selector(typeFilterButtonTapped), for: .touchUpInside)
        dropDown.anchorView = navigationController?.navigationBar
        dropDown.cellHeight = 50
        dropDown.direction = .bottom
        dropDown.bottomOffset = CGPoint(x: 0, y: dropDown.anchorView!.plainView.bounds.height)
        dropDown.backgroundColor = .white
        dropDown.selectionBackgroundColor = .lightGray
        dropDown.textColor = .black
        dropDown.cornerRadius = 10
        dropDown.dataSource = Defaults.typeStringsArray
        return dropDown
    }
    
    private func configureTypeDropDown() {
        typeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.typeFilter = ZooObjectType(rawValue: index)
            self.typeFilterButton.setTitle(item, for: .normal)
            self.typeDropDown.hide()
        }
    }
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // request location
        setLocationManager()
        mapView.region = initialMapRegion
        mapView.addOverlay(zooOverlay, level: .aboveLabels)
        setZoomGestureRecognizer()
        Routes.allPolylines.forEach { mapView.addOverlay($0) }
        loadZooObjectData()
        
        mapView.register(
            ZooAnnotationView.self,
            forAnnotationViewWithReuseIdentifier: Defaults.reuseId
        )
        
        addAnnotations()
        showAnnotationsOnMap()
        configureTypeDropDown()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.filterForSelectedArea(_:)),
            name: NSNotification.Name(rawValue: "areaSelected"),
            object: nil)
    }
    
    @IBAction func selectAreaFilterButtonTapped(_ sender: Any) {
        let pickerController = UINavigationController(rootViewController: PickAreaViewController())
        pickerController.modalPresentationStyle = .overCurrentContext
        present(pickerController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapToObjectDetailSegue" {
            let destVC = segue.destination as? ObjectDetailViewController
            destVC?.object = sender as? ZooObject
            destVC?.fromMap = true
        }
    }
    
    func loadZooObjectData() {
        // remove previous objects
        currentObjects.removeAll()
        zoo.allObjectArrays.forEach { currentObjects.append(contentsOf: $0) }
        
        if self.hasActiveFilter {
            filterObjects()
        }
    }
    
    func addAnnotations() {
        zooAnnotations.removeAll()
        
        currentObjects.forEach {
            // add annotation to annotations list
            zooAnnotations.append(ZooAnnotation(object: $0))
            
            // if animal in more than one location
            if let animalObject = $0 as? Animal, animalObject.alternateLocations != nil {
                zooAnnotations.append(contentsOf: animalObject.allLocationAnnotations!)
            }
        }
    }
    
    func showAnnotationsOnMap() {
        mapView.removeAnnotations(mapView.annotations)
        
        zooAnnotations.forEach {
            mapView.addAnnotation($0)
        }
    }
    
    // remove memory allocations on pop to main tab controller
    @IBAction func doneTapped(_ sender: Any) {
        zoomInterceptor = nil
        mapView.gestureRecognizers = nil
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        locationManager.stopUpdatingLocation()
        NotificationCenter.default.removeObserver(self)
        dismiss(animated: true)
    }
    
    var mapShowing: Bool = true {
        didSet {
            tableView.isHidden = !tableView.isHidden
            
            if mapShowing {
                showButton.title = "Show List"
            } else {
                showButton.title = "Show Map"
            }
        }
    }
    
    @IBAction func showButtonTapped(_ sender: Any) {
        mapShowing = !mapShowing
    }
    
    @objc func typeFilterButtonTapped() {
        typeDropDown.show()
    }
}

extension MapViewController: MapViewZoomInterceptor {
    
    func setZoomGestureRecognizer() {
        zoomInterceptor = WildCardGestureRecognizer(target: nil, action: nil)
        setMapViewZoomInterceptor(mapView: mapView)
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    private func setLocationManager() {
        // Request user location
        locationManager.requestWhenInUseAuthorization()
        
        guard CLLocationManager.locationServicesEnabled() else {
            print("location isn't authorized yet")
            return
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    // Overlays
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        switch overlay {
        case let zooOverlay as ZooOverlay:
            return MKTileOverlayRenderer(tileOverlay: zooOverlay)
        case let zooPolyline as ZooPolyline:
            return zooPolyline.getPolylineRenderer()
        default: return MKOverlayRenderer()
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? ZooAnnotation {
            return annotation.getAnnotationView()
        }
        
        return nil
    }
    
    // Showing details for selected callouts
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegue(
            withIdentifier: Defaults.objectDetailSegueId,
            sender: (view.annotation as! ZooAnnotation).object
        )
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
        let object = currentObjects.sorted()[indexPath.row]
        cell.setCellViews(object: object)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(
            withIdentifier: Defaults.objectDetailSegueId,
            sender: currentObjects.sorted()[indexPath.row]
        )
    }
}

extension MapViewController {
    private struct Defaults {
        static let reuseId = MKMapViewDefaultAnnotationViewReuseIdentifier
        static let minimumZoom = 17
        static let maximumZoom = 19
        static let objectDetailSegueId = "mapToObjectDetailSegue"
        static let span = MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.0)
        
        static let typeStringsArray = [
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
    }
    
    var initialMapRegion: MKCoordinateRegion {
        let perimeter = zoo.perimeter
        
        let span = MKCoordinateSpan(
            latitudeDelta: fabs(
                perimeter.overlayTopLeftCoordinate.latitude
                - perimeter.overlayBottomRightCoordinate.latitude
            ),
            longitudeDelta: 0.0
        )
        
        return MKCoordinateRegion(
            center: perimeter.midCoordinate,
            span: span
        )
    }
    
    var defaultRegion: MKCoordinateRegion {
        return MKCoordinateRegion(
            center: mapView.centerCoordinate,
            span: Defaults.span
        )
    }
    
    private var hasActiveFilter: Bool {
        return areaFilter != nil && areaFilter != .unknown || typeFilter != nil && typeFilter != .unknown
    }
}

extension CGPoint {
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(CLLocationDegrees(self.x), CLLocationDegrees(self.y))
    }
    
}
