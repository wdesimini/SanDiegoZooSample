//
//  ExperienceTableViewCell.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/12/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit

class ExperienceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var experienceImageView: UIImageView!
    @IBOutlet weak var experienceLabel: UILabel!
    
    func setExperience(experience: Experience) {
        experienceLabel.text = experience.title
        experienceImageView.image = UIImage(named: "gator_thumbnail")!
        accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
    }
//    
//    func imageFromString(_ imageString: String?) -> UIImage {
//        guard let string = imageString, let image = UIImage(named: string) else {
//            
//            return UIImage(named: "gator_thumbnail")! // know exists, unwrap
//        }
//        
//        // had imageString and image from string exists
//        return image
//    }
}
