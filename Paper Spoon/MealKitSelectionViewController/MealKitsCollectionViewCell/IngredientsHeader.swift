//
//  IngredientsHeader.swift
//  HF Test
//
//  Created by Daniel Lee on 5/13/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class IngredientsHeader: UICollectionViewCell {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: - UI Elements
    let title = UILabel()
    
    internal func setup() {
        title.text = "Ingredients"
        title.font = UIFont.fontBebas?.withSize(30)
        
        self.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -2).isActive = true
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 2).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
