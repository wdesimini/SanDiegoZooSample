//
//  ZooObject+View.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 9/17/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit

private let defaultImage = UIImage(named: "zoo_logo2")!

extension ZooObject {
    
    var image: UIImage {
        if let imgStr = imageString {
            return UIImage(named: imgStr)!
        }
        
        return defaultImage
    }
    
}
