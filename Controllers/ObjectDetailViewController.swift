//
//  ObjectDetailViewController.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit
import CoreLocation

private let defaultImage = UIImage(named: "zoo_logo")
class ObjectDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewOnMapButton: UIButton!
    @IBOutlet weak var viewMenuButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    var object: ZooObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusLabel.isHidden = true
        viewMenuButton.isHidden = true
        
        loadObjectViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // revert navigation bar title back to nothing
        navigationItem.title = nil
        
        UIView.animate(withDuration: 0.2, animations: {
            self.imageView.alpha = 0
        }) { _ in
            self.imageView.image = nil
        }
    }
    
    func loadObjectViews() {
        // set navigation bar title
        self.navigationItem.title = object.name
        
        setImage()
        
        summaryLabel.text = object.summary
        
        switch object.type {
        case .animal:
            setAnimalViews()
        case .dining:
            setDiningViews()
        default:
            break
        }
    }
    
    func setImage() {
        // set image
        guard let imageString = object.imageString else {
            imageView.image = defaultImage
            
            return
        }
        
        if let image = UIImage(named: imageString) {
            imageView.image = image
        } else {
            imageView.image = defaultImage
        }
    }
    
    func setAnimalViews() {
        let animal = object as! Animal
        
        statusLabel.isHidden = false
        statusLabel.text = animal.conservationStatus.getString()
    }
    
    func setDiningViews() {
        let restaurant = object as! Dining
        
        if restaurant.menuString != nil {
            viewMenuButton.isHidden = false
        }
    }
    
}
