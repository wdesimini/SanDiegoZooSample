//
//  CustomTabBarController.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/15/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit


class CustomTabBarController: UITabBarController {
    
    private let mapButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Map", for: .normal)
        button.setTitleColor(MyColors.darkGreen, for: .normal)
        button.addTarget(self, action: #selector(mapButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private func configureMapButton() {
        mapButton.setImage(buttonImage, for: .normal)
        view.addSubview(mapButton)
        
        let mapButtonW = tabBar.frame.width / CGFloat(tabBarItemCount)
        
        NSLayoutConstraint.activate([
            mapButton.topAnchor.constraint(equalTo: tabBar.topAnchor),
            mapButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapButton.widthAnchor.constraint(equalToConstant: mapButtonW),
            mapButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            ])
    }
    
    override func loadView() {
        super.loadView()
        tabBar.itemPositioning = .fill
        tabBar.itemSpacing = tabBarItemSpacing
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapButton()
    }

    @objc func mapButtonTapped() {
        performSegue(withIdentifier: "showMapSegue", sender: nil)
    }
}

extension CustomTabBarController {
    
    private var buttonImage: UIImage? {
        return UIImage(named: "map_tabIcon")
    }
    
    private var tabBarItemCount: Int {
        return tabBar.items!.count + 1
    }
    
    private var tabBarItemSpacing: CGFloat {
        let itemWidth = tabBar.frame.width / CGFloat(tabBarItemCount)
        return itemWidth * 2
    }
}
