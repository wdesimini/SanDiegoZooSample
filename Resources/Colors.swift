//
//  Colors.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/12/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit

struct MyColors {
    static let darkGreen = hexStringToUIColor(hex: "#3b6c34")
    static let orange = hexStringToUIColor(hex: "#ee8251")
    static let diningGreen = hexStringToUIColor(hex: "#489744")
    static let shoppingRed = hexStringToUIColor(hex: "#ea0b1e")
    static let cateringOrange = hexStringToUIColor(hex: "#f6a025")
    static let generalPurple = hexStringToUIColor(hex: "91538a")
    
    static let lostForestGreen = hexStringToUIColor(hex: "7db840")
    static let discoveryOutpostRed = hexStringToUIColor(hex: "9a2c39")
    static let outbackPurple = hexStringToUIColor(hex: "5c2f44")
    static let urbanJungleOrange = hexStringToUIColor(hex: "c05312")
    static let asianPassagePurple = hexStringToUIColor(hex: "58567d")
    static let africaRocksGreen = hexStringToUIColor(hex: "828335")
    static let elephantOdysseyBrown = hexStringToUIColor(hex: "b67e41")
    static let pandaCanyonRed = hexStringToUIColor(hex: "96543e")
    static let northernFrontierBlue = hexStringToUIColor(hex: "659fa0")
    
    static func hexStringToUIColor(hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count != 6 {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
