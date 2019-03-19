//
//  CustomTabBarController.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/15/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit

private let buttonImage = UIImage(named: "map_tabIcon")

class CustomTabBarController: UITabBarController {
    
    let mapButton = UIButton(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.itemPositioning = .fill
        
        setMapButton()
    }
    
    func setMapButton() {
        let itemCount = CGFloat(tabBar.items!.count) + 1 // + 1 because this button will also be item
        let itemWidth = tabBar.frame.width / itemCount
        let tabBarItemSize = CGSize(width: itemWidth, height: tabBar.frame.height)
        
        tabBar.itemSpacing = itemWidth * 2
        
        mapButton.frame = CGRect(x: 0, y: 0, width: tabBarItemSize.width, height: tabBar.frame.size.height)
        
        var mapButtonFrame = mapButton.frame
        
        mapButtonFrame.origin.y = view.bounds.height - mapButtonFrame.height - view.safeAreaInsets.bottom
        mapButtonFrame.origin.x = view.bounds.width/2 - mapButtonFrame.size.width/2
        
        mapButton.frame = mapButtonFrame
        mapButton.setImage(buttonImage, for: .normal)
        mapButton.setTitle("Map", for: .normal)
        mapButton.setTitleColor(MyColors.darkGreen, for: .normal)
        
        view.addSubview(mapButton)
        view.layoutIfNeeded()
        
        mapButton.addTarget(self, action: #selector(mapButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapButton.frame.origin.y = view.bounds.height - mapButton.frame.height - view.safeAreaInsets.bottom
    }
    
    @objc func mapButtonTapped() {
        performSegue(withIdentifier: "showMapSegue", sender: nil)
    }
}
