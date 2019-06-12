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
        let items = Zoo.plist("Shopping Areas") as! [[String: AnyObject]]
        return items.map { getShoppingObject(from: $0) }
    }()
}

extension ShoppingData {
    
    func getShoppingObject(from item: [String: AnyObject]) -> ZooObject {
        return ZooObject(
            name: item["name"] as! String,
            coordinate: Zoo.parseCoord(dict: item, fieldName: "coordinate"),
            imageString: item["imageString"] as? String,
            areaPointer: item["area"] as! Int,
            type: .shopping,
            summary: item["summary"] as? String
        )
    }
    
}
