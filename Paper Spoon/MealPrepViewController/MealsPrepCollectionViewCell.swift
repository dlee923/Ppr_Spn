//
//  MealsPrepCollectionViewCell.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/25/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class MealsPrepCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mealsPrepImag: UIImageView!
    @IBOutlet weak var ingredientsPrepTableView: IngredientsPrepTableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
    }
    
    var menuOption: MenuOption? {
        didSet {
            self.ingredientsPrepTableView.recipe = self.menuOption?.recipe
        }
    }
    
    private func setup() {
        
    }

}
