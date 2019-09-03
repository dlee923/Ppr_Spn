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
    @IBOutlet weak var mealPreppedBtn: UIButton!
    @IBAction func mealPreppedBtnPressed(_ sender: Any) {
        self.mealPreppedAction()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        self.setup()
    }
    
    var menuOption: MenuOption? {
        didSet {
            self.ingredientsPrepTableView.recipe = self.menuOption?.recipe
            self.ingredientsPrepTableView.reloadData()
        }
    }
    
    weak var mealPrepFinishedDelegate: MealPrepFinishedDelegate?
    
    private func setup() {
        self.mealPreppedBtn.titleLabel?.font = UIFont.fontSunflower?.withSize(20)
    }
    
    private func mealPreppedAction() {
        print("meal kit prepped")
        self.mealPrepFinishedDelegate?.sendUserToMealKitSelection()

        
    }

}
