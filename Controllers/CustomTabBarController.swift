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
        button.setTitle("Map", for: .normal)
        button.setTitleColor(MyColors.darkGreen, for: .normal)
        button.addTarget(self, action: #selector(mapButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private func configureMapButton() {
        mapButton.frame = mapButtonFrame
        mapButton.setImage(buttonImage, for: .normal)
        view.addSubview(mapButton)
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
    
    private var mapButtonSize: CGSize {
        return CGSize(
            width: tabBar.frame.width / CGFloat(tabBarItemCount),
            height: tabBar.frame.height
        )
    }
    
    private var mapButtonOrigin: CGPoint {
        return CGPoint(
            x: view.bounds.width / 2 - mapButtonSize.width / 2,
            y: view.bounds.height - mapButtonSize.height - view.safeAreaInsets.bottom
        )
    }
    
    private var mapButtonFrame: CGRect {
        return CGRect(
            origin: mapButtonOrigin,
            size: mapButtonSize
        )
    }
}
