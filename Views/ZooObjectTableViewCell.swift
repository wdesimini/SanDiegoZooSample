//
//  ZooObjectTableViewCell.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/11/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit

private let defaultImage = UIImage(named: "zoo_logo2")

class ZooObjectTableViewCell: UITableViewCell {

    @IBOutlet weak var objectImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    func setCellViews(object: ZooObject) {
        
        // set labels
        titleLabel.text = object.name
        subtitleLabel.text = object.area.getAreaName()
        
        // set image
        guard let imageString = object.imageString,
            let image = UIImage(named: imageString) else {
            objectImageView.image = defaultImage
            return
        }
        
        objectImageView.image = image
    }
}
