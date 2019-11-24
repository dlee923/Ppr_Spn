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
    @IBOutlet weak var ingredientsPrepCollectionView: IngredientsPrepCollectionView!
    @IBOutlet weak var mealPreppedBtn: UIButton!
    @IBAction func mealPreppedBtnPressed(_ sender: Any) {
        self.mealPreppedAction()
    }
    @IBOutlet weak var mealsPrepHeaderView: UIView!
    @IBOutlet weak var mealsPrepLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.themeColor1
        self.setup()
        self.customMealPrepButtonDimensions()
    }
    
    var menuOption: MenuOption? {
        didSet {
            self.ingredientsPrepCollectionView.recipe = self.menuOption?.recipe
            self.mealsPrepImage.image = self.menuOption?.recipe?.recipeImage
            self.mealsPrepLabel.text = self.menuOption?.recipeName
            self.ingredientsPrepCollectionView.reloadData()
        }
    }
    
    weak var mealPrepFinishedDelegate: MealPrepFinishedDelegate?
    
    private func setup() {
        self.mealPreppedBtn.titleLabel?.font = UIFont.fontSunflower?.withSize(20)
        self.mealPreppedBtn.layer.cornerRadius = 5
        self.mealsPrepHeaderView.layer.cornerRadius = 50
        self.mealsPrepImage.layer.cornerRadius = 40
        self.mealsPrepImage.clipsToBounds = true
        self.mealsPrepLabel.font = UIFont.fontBebas?.withSize(20)
    }
    
    private func customMealPrepButtonDimensions() {
        self.mealPreppedBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.mealPreppedBtn.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            self.mealPreppedBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.mealPreppedBtn.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.mealPreppedBtn.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05)
        ])
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
