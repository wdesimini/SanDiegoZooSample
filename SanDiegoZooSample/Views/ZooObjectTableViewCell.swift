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
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        
        return label
    }()
    
    let objSubtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        
        return label
    }()
    
    func setCellViews(object: ZooObject) {
        
        // add image object
        contentView.addSubview(objImageView)
        
        // add stackView for labels
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.addArrangedSubview(objTitleLabel)
        stackView.addArrangedSubview(objSubtitleLabel)
        
        contentView.addSubview(stackView)
        
        // set constraints
        NSLayoutConstraint.activate([
            objImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            objImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            objImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -10),
            objImageView.widthAnchor.constraint(equalTo: objImageView.heightAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: objImageView.rightAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackView.heightAnchor.constraint(equalTo: objImageView.heightAnchor)
            ])
        
        // set labels
        objTitleLabel.text = object.name
        objSubtitleLabel.text = object.area.getAreaName()
        
        // set image's frame for circlemasking
        let cellHeight = contentView.frame.height - 10
        objImageView.frame.size = CGSize(width: cellHeight, height: cellHeight)
        objImageView.circleMask()
        
        objImageView.image = object.image
    }
}
