//
//  filterSearchObjects.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/19/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation
import UIKit

// areaPickerView extension

extension SearchViewController {
    
    func setAreaPickerView() {
        
        // add button as titleView
        navigationItem.titleView = selectAreaFilterButton
        selectAreaFilterButton.addTarget(self, action: #selector(selectAreaFilterTapped), for: .touchUpInside)
        
        // set pickerView
        areaPickerView.dataSource = self
        areaPickerView.delegate = self
        
        // add views
        view.addSubview(pickerContainerView)
        pickerContainerView.addSubview(areaPickerView)
        pickerContainerView.addSubview(areaFilterButton)
        
        // set button target
        areaFilterButton.addTarget(self, action: #selector(areaFilterButtonTap), for: .touchUpInside)
        
        let pickerContainerViewHeight: CGFloat = 200
        let areaPickerViewMultiplier: CGFloat = 0.80
        
        // set view constraints
        NSLayoutConstraint.activate([
            
            // pickerContainerView
            pickerContainerView.bottomAnchor.constraint(equalTo: view.topAnchor),
            pickerContainerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            pickerContainerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            pickerContainerView.heightAnchor.constraint(equalToConstant: pickerContainerViewHeight),
            
            // areaPickerView
            areaPickerView.topAnchor.constraint(equalTo: pickerContainerView.topAnchor),
            areaPickerView.leftAnchor.constraint(equalTo: pickerContainerView.leftAnchor),
            areaPickerView.rightAnchor.constraint(equalTo: pickerContainerView.rightAnchor),
            areaPickerView.heightAnchor.constraint(equalToConstant: pickerContainerViewHeight * areaPickerViewMultiplier),
            
            // areaFilterButton
            areaFilterButton.topAnchor.constraint(equalTo: areaPickerView.bottomAnchor),
            areaFilterButton.leftAnchor.constraint(equalTo: pickerContainerView.leftAnchor),
            areaFilterButton.rightAnchor.constraint(equalTo: pickerContainerView.rightAnchor),
            areaFilterButton.bottomAnchor.constraint(equalTo: pickerContainerView.bottomAnchor)
            
            ])
    }
    
    @objc func areaFilterButtonTap() {
        
        // filter search object array
        filterSearchObjects()
        
        // hide pickerView
        guard let height = navigationController?.navigationBar.frame.height else { return }
        
        let offScreenY = height - pickerContainerView.frame.height
        
        UIView.animate(withDuration: 0.2) {
            self.pickerContainerView.frame.origin.y = offScreenY
        }
        
        // adjust filter button appearance
        setAreaFilterButtonAppearance()
    }
    
    // modify button appearance on filter action
    
    func setAreaFilterButtonAppearance() {
        
        var title: String
        var backgroundColor: UIColor
        var titleColor: UIColor
        var borderColor: CGColor
        
        switch areaFilter {
        case nil:
            title = "select area filter"
            backgroundColor = .clear
            titleColor = .black
            borderColor = UIColor.black.cgColor
        default:
            title = areaFilter!.getAreaName()
            backgroundColor = areaFilter!.getAreaColor()
            titleColor = .white
            borderColor = UIColor.clear.cgColor
        }
        
        selectAreaFilterButton.setTitle(title, for: .normal)
        selectAreaFilterButton.backgroundColor = backgroundColor
        selectAreaFilterButton.setTitleColor(titleColor, for: .normal)
        selectAreaFilterButton.layer.borderColor = borderColor
    }
    
    // filter points
    
    func filterSearchObjects() {
        
        // remove previous objects from array
        searchItem.removeAll()
        objects.removeAll()
        
        // load all data into array
        loadObjectData()
        
        if searching {
            filterSearchItemArray()
        } else {
            filterObjectsArray()
        }
        
    }
    
    func filterSearchItemArray() {
        
        // filter objects for searchBar text
        searchItem = objects.filter {
            return $0.name.localizedCaseInsensitiveContains(searchBar.text!)
        }
        
        // check at least one filter
        guard (areaFilter != nil || typeFilter != nil) else {
            tableView.reloadData()
            return
        }
        
        // filter data
        if areaFilter != nil  {
            searchItem = searchItem.filter {
                $0.area == areaFilter
            }
        }
        
        if typeFilter != nil {
            searchItem = searchItem.filter {
                $0.type == typeFilter
            }
        }
        
        tableView.reloadData()
    }
    
    func filterObjectsArray() {
        
        // check at least one filter
        guard (areaFilter != nil || typeFilter != nil) else {
            tableView.reloadData()
            return
        }
        
        // filter data
        
        if areaFilter != nil  {
            objects = objects.filter {
                $0.area == areaFilter
            }
        }
        
        if typeFilter != nil {
            objects = objects.filter {
                $0.type == typeFilter
            }
        }
        
        tableView.reloadData()
    }
}

extension SearchViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return areas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let area = areas[row]
        
        if area == .unknown {
            return "No Filter"
        }
        
        return area.getAreaName()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let area = areas[row]
        
        guard area != .unknown else {
            areaFilter = nil
            return
        }
        
        areaFilter = area
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchTypeCollectionViewCell
        let type = types[indexPath.item]
        
        cell.setImage(type)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type = types[indexPath.item]
        
        typeFilter = type
        
        filterSearchObjects()
        
        UIView.animate(withDuration: 0.2) {
            self.selectTypeFilterButton.alpha = 1
        }
    }
}
