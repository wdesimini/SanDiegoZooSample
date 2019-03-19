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
    
    let zoo = Zoo(name: "San Diego Zoo")
    var objects = [ZooObject]()
    
    // search bar items
    var searchItem = [ZooObject]()
    var searching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load data into search table
        loadObjectData()
        setTableView()
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
            zoo.animals,
            zoo.restaurants,
            zoo.mapLocations,
            zoo.parkingLotSigns]
        
        zooObjects.forEach {
            objects.append(contentsOf: $0)
        }
        
        #warning("add nameless objects as groups to table")
        // nameless objects in groups
//        let restrooms = zoo.restrooms
//        let waterFountains = zoo.waterFountains
    }
    
    func setTableView() {
//        tableView.layer.shouldRasterize = true
//        tableView.layer.rasterizationScale = 2
//        tableView.keyboardDismissMode = .onDrag
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
            searchItem.removeAll()
        } else {
            searching = true
            
            searchItem = objects.filter {
                return $0.name.localizedCaseInsensitiveContains(searchBar.text!)
            }
        }
        
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        searching = false
        tableView.reloadData()
    }
}
