//
//  PickAreaViewController.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/18/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit

class PickAreaViewController: UIViewController {
    
    var areas: [ZooArea] = {[
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
    
    let picker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.backgroundColor = .white
        
        return pickerView
    }()
    
    let filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Apply filter", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        button.setTitleColor(MyColors.darkGreen, for: .normal)
        
        return button
    }()
    
    var receivedArea: ZooArea = .africaRocks
    
    @objc fileprivate func handlePress(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        
        setupView()
    }
    
    func setupView(){
        view.backgroundColor = .white
        
        view.addSubview(picker)
        view.addSubview(filterButton)
        
        let height: CGFloat = 80
        
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            filterButton.heightAnchor.constraint(equalToConstant: height),
            filterButton.widthAnchor.constraint(equalTo: view.widthAnchor),
            filterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
//            picker.topAnchor.constraint(equalTo: view.topAnchor, constant: height),
            picker.topAnchor.constraint(equalTo: filterButton.bottomAnchor),
            picker.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            picker.leftAnchor.constraint(equalTo: view.leftAnchor),
            picker.rightAnchor.constraint(equalTo: view.rightAnchor)
            
            ])
        
    }
    
    @objc func filterButtonTapped() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "areaSelected"), object: receivedArea)
        
        dismiss(animated: true, completion: nil)
    }
}

extension PickAreaViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        receivedArea = area
    }
}
