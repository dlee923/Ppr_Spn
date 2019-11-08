//
//  MealsPrepCollectionViewCell.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/25/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class MealsPrepCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mealsPrepImage: UIImageView!
    @IBOutlet weak var ingredientsPrepTableView: IngredientsPrepTableView!
    @IBOutlet weak var mealPreppedBtn: UIButton!
    @IBAction func mealPreppedBtnPressed(_ sender: Any) {
        self.mealPreppedAction()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.themeColor1
        self.setup()
    }
    
    var menuOption: MenuOption? {
        didSet {
            self.ingredientsPrepTableView.recipe = self.menuOption?.recipe
            self.mealsPrepImage.image = self.menuOption?.recipe?.recipeImage
            self.ingredientsPrepTableView.reloadData()
        }
    }
    
    weak var mealPrepFinishedDelegate: MealPrepFinishedDelegate?
    
    private func setup() {
        self.mealPreppedBtn.titleLabel?.font = UIFont.fontSunflower?.withSize(20)
        self.mealPreppedBtn.layer.cornerRadius = 5
    }
    
    private func mealPreppedAction() {
        guard let menuOption = self.menuOption else { return }
        print("meal kit prepped")
        // mark menu option as being meal kit complete
        self.menuOption?.isMealKitComplete = true
        
        
        // button animation to transition screen
        
        
        // reload the meal kits selection view controller and add to kittedMenuOptions
        self.mealPrepFinishedDelegate?.addToPreppedMeals(menuOption: menuOption)
    }
    

}
