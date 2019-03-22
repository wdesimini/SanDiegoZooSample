//
//  ShoppingData.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/21/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation
import CoreLocation


class ShoppingData {
    lazy var shoppingAreas: Array<ZooObject> = {
        var shoppingList: [ZooObject] = []
        let items = Zoo.plist("Shopping Areas") as! [[String: AnyObject]]
        
        for item in items {
            
            let name = item["name"] as! String
            let coordinate = Zoo.parseCoord(dict: item, fieldName: "coordinate")
            let imageString = item["imageString"] as? String
            let pointer = item["area"] as! Int
            let summary = item["summary"] as? String
            
            var object: ZooObject
            
            object = ZooObject(name: name,
                               coordinate: coordinate,
                               imageString: imageString,
                               areaPointer: pointer,
                               type: .shopping,
                               summary: summary)
            
            shoppingList.append(object)
        }
        
        return shoppingList
    }()
}
