//
//  IngredientsPillCell.swift
//  HF Test
//
//  Created by Daniel Lee on 5/13/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class IngredientsPillCell: UICollectionViewCell {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: - Static Properties
    static let ingredientPillFont = UIFont.fontCoolvetica?.withSize(12)
    
    // MARK: - UI Elements
    let ingredient = UILabel()
    
    // MARK: - Setup method
    internal func setup() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        
        self.addLabel()
        self.modifyLabel()
    }
    
    internal func addLabel() {
        self.addSubview(self.ingredient)
        ingredient.translatesAutoresizingMaskIntoConstraints = false
        ingredient.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        ingredient.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -2).isActive = true
        ingredient.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        ingredient.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 2).isActive = true
    }
    
    internal func modifyLabel() {
        self.ingredient.textAlignment = .center
        self.ingredient.font = IngredientsPillCell.ingredientPillFont
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
