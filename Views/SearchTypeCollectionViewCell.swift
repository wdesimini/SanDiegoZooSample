//
//  SearchTypeCollectionViewCell.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/19/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//


import UIKit

class SearchTypeCollectionViewCell: UICollectionViewCell {
    
    let typeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    func setImage(_ type: ZooObjectType) {
        
        // add imageView
        contentView.addSubview(typeImageView)
        
        // set constraints
        NSLayoutConstraint.activate([
            
            typeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            typeImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            typeImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            typeImageView.widthAnchor.constraint(equalTo: typeImageView.heightAnchor),
            
            ])
        
        if type == .general {
            typeImageView.backgroundColor = .black
            typeImageView.circleMask()
            typeImageView.layer.borderColor = UIColor.clear.cgColor
        }
        
        typeImageView.image = getTypeImageFromType(type)
    }
    
    func getTypeImageFromType(_ type: ZooObjectType) -> UIImage {
        
        switch type {
        case .animal:
            return UIImage(named: "Animal Glyph")!
        case .dining:
            return UIImage(named: "Dining Glyph")!
        case .shopping:
            return UIImage(named: "Shopping Glyph")!
        case .catering:
            return UIImage(named: "Catering Glyph")!
        case .aviary:
            return UIImage(named: "Aviary Glyph")!
        case .mapLocation:
            return UIImage(named: "Map Location Glyph")!
        case .parkingLotSign:
            return UIImage(named: "Parking Lot Glyph")!
        case .general:
            return UIImage(named: "G&A Glyph")!
        case .waterFountain:
            return UIImage(named: "Water Fountain Glyph")!
        case .restroom:
            return UIImage(named: "Restroom Glyph")!
        default:
            return UIImage(named: "G&A Glyph")!
        }
    }
}
