//
//  ZooAreaPickerView.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/18/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit

class ZooAreaPickerView: UIPickerView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
