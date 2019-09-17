//
//  IntermediateViewController.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/12/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit

class IntermediateViewController: UIViewController {
    
    var toMap = true
    
    // imageView
    let zooLogoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "zoo_logo"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addImageView()
    }
    
    func addImageView() {
        // add loading animation
        view.addSubview(zooLogoImageView)
        
        NSLayoutConstraint.activate([
            zooLogoImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60),
            zooLogoImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60),
            zooLogoImageView.heightAnchor.constraint(equalToConstant: 200 ),
            zooLogoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        transitionFromView()
    }
    
    func transitionFromView() {
        // if coming back from map vc, go to next index in tab bar controller
        guard toMap else {
            goToTabBarController()
            
            return
        }
        
        segueToMap()
        
        // set toMap Bool to opposite for next time
        toMap = !toMap
    }
    
    func goToTabBarController() {
        let tabBarController = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBarController
    }
    
    func segueToMap() {
        // if map icon pressed, go to map vc
        
        performSegue(withIdentifier: "intermediateSegueToMapVC", sender: nil)
    }
}
