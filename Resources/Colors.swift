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
}


func hexStringToUIColor(hex: String) -> UIColor {
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
