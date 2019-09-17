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
}
