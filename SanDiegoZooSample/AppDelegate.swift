//
//  AppDelegate.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit
import DropDown

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DropDown.startListeningToKeyboard()
        
        return true
    }
    
    lazy var animalData = AnimalData()
    lazy var diningData = DiningData()
    lazy var shoppingData = ShoppingData()
    lazy var cateringData = CateringData()
    lazy var generalData = GeneralData()
    lazy var restroomData = RestroomData()
    lazy var waterFountainData = WaterFountainData()
    lazy var aviaryData = AviaryData()
    lazy var mapLocationData = MapLocationData()
    lazy var parkingLotSignData = ParkingLotSignData()
}

