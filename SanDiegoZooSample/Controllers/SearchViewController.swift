//
//  ViewController.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectTypeFilterButton: UIButton!
    
    let zoo = Zoo(name: "San Diego Zoo")
    
    var objects = [ZooObject]()  {
        didSet {
            objects = objects.sorted()
        }
    }
    
    // search bar items
    var searchItem = [ZooObject]() {
        didSet {
            searchItem = searchItem.sorted()
        }
    }
    
    var searching: Bool = false
    
    // picker view
    
    let selectAreaFilterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame.size = CGSize(width: 120, height: 44)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("select area filter", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    let pickerContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    let areaPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        return pickerView
    }()
    
    let areaFilterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(MyColors.darkGreen, for: .normal)
        button.setTitle("Apply filter", for: .normal)
        
        return button
    }()
    
    var areaFilter: ZooArea? = nil
    var typeFilter: ZooObjectType? = nil
    
    let areas: [ZooArea] = {[
        ZooArea.africaRocks,
        ZooArea.asianPassage,
        ZooArea.discoveryOutpost,
        ZooArea.elephantOdyssey,
        ZooArea.lostForest,
        ZooArea.northernFrontier,
        ZooArea.outback,
        ZooArea.pandaCanyon,
        ZooArea.parkingLot,
        ZooArea.urbanJungle,
        ZooArea.unknown
        ]}()
    
    let types: [ZooObjectType] = {[
        ZooObjectType.animal,
        ZooObjectType.aviary,
        ZooObjectType.catering,
        ZooObjectType.dining,
        ZooObjectType.general,
        ZooObjectType.mapLocation,
        ZooObjectType.parkingLotSign,
        ZooObjectType.restroom,
        ZooObjectType.shopping,
        ZooObjectType.waterFountain
        ]}()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load data into search table
        loadObjectData()
        setTableView()
        setAreaPickerView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSegueToDetailVC" {
            let destVC = segue.destination as? ObjectDetailViewController
            destVC?.object = sender as? ZooObject
        }
    }
    
    func loadObjectData() {
        
        // load named objects
        let zooObjects: [[ZooObject]] = [
            zoo.animalDataSource,
            zoo.aviaryDataSource,
            zoo.diningDataSource,
            zoo.cateringDataSource,
            zoo.shoppingDataSource,
            zoo.restroomDataSource,
            zoo.waterFountainDataSource,
            zoo.mapLocationDataSource,
            zoo.parkingLotSignDataSource,
            zoo.generalDataSource]
        
        zooObjects.forEach {
            objects.append(contentsOf: $0)
        }
    }
    
    func setTableView() {
        tableView.layer.shouldRasterize = true
        tableView.layer.rasterizationScale = 2
        tableView.keyboardDismissMode = .onDrag
    }
    
    @objc func selectAreaFilterTapped() {
        
        // select previous filter
        if areaFilter != nil {
            let row = areas.firstIndex(of: areaFilter!)
            areaPickerView.selectRow(row!, inComponent: 0, animated: false)
        } else {
            // filter is nil, set on "No Filter"
            let rowCount = areas.count - 1
            areaPickerView.selectRow(rowCount, inComponent: 0, animated: false)
        }
        
        // show pickerView
        guard let height = navigationController?.navigationBar.frame.height else { return }
        
        UIView.animate(withDuration: 0.2) {
            self.pickerContainerView.frame.origin.y = height
        }
    }
    
    @IBAction func selectTypeFilterButtonTapped(_ sender: Any) {
        
        // hide self
        UIView.animate(withDuration: 0.2) {
            self.selectTypeFilterButton.alpha = 0
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        
        typeFilter = nil
        filterSearchObjects()
        
        UIView.animate(withDuration: 0.2) {
            self.selectTypeFilterButton.alpha = 1
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching {
            return searchItem.count
        } else {
            return objects.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! ZooObjectTableViewCell
        var object: ZooObject
        
        if searching {
            object = searchItem[indexPath.row]
        } else {
            object = objects[indexPath.row]
        }
        
        cell.setCellViews(object: object)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var object: ZooObject
        
        if searching {
            object = searchItem[indexPath.row]
        } else {
            object = objects[indexPath.row]
        }
        
        self.performSegue(withIdentifier: "searchSegueToDetailVC", sender: object)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            searching = false
        } else {
            searching = true
        }
        
        filterSearchObjects()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        searching = false
        filterSearchObjects()
    }
}
