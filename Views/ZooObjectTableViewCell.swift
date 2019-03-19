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
    
    let objImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let objTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let objSubtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        
        return label
    }()
    
    func setCellViews(object: ZooObject) {
        
        // add image object
        contentView.addSubview(objImageView)
        
        // add stackView for labels
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.addArrangedSubview(objTitleLabel)
        stackView.addArrangedSubview(objSubtitleLabel)
        
        contentView.addSubview(stackView)
        
        // set constraints
        NSLayoutConstraint.activate([
            objImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            objImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            objImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -10),
            objImageView.widthAnchor.constraint(equalTo: objImageView.heightAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: objImageView.rightAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackView.heightAnchor.constraint(equalTo: objImageView.heightAnchor)
            ])
        
        // set labels
        objTitleLabel.text = object.name
        objSubtitleLabel.text = object.area.getAreaName()
        
        // set image
        let cellHeight = contentView.frame.height - 10
        objImageView.frame.size = CGSize(width: cellHeight, height: cellHeight)
        objImageView.circleMask()
        
        guard let imageString = object.imageString, let image = UIImage(named: imageString) else {
            objImageView.image = defaultImage
            return
        }
        
        objImageView.image = image
    }
}
