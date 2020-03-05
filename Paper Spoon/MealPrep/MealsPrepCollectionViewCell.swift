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
    var mealPreppedBtnView: NextStepBtnView?
    @IBOutlet weak var mealsPrepHeaderView: UIView!
    @IBOutlet weak var mealsPrepLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.themeColor1
        self.setup()
//        self.addMealPreppedBtnView()
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
        self.mealsPrepHeaderView.backgroundColor = UIColor.themeColor1
        
        self.mealsPrepImage.clipsToBounds = true
        self.mealsPrepLabel.font = UIFont.fontBebas?.withSize(30)
        self.mealsPrepLabel.textColor = UIColor.themeColor2
        self.mealsPrepLabel.backgroundColor = UIColor.themeColor1
        
        self.ingredientsPrepCollectionView.mealsPrepCollectionViewCellDelegate = self
    }
    
    func addMealPreppedBtnView() {
        self.mealPreppedBtnView = NextStepBtnView(frame: self.frame)
        self.mealPreppedBtnView?.compileIngredientsBtn?.setTitle("Ingredients Packed", for: .normal)
        
        // remove finger
        self.mealPreppedBtnView?.finger.removeFromSuperview()
        guard let mealPreppedBtnView = self.mealPreppedBtnView else { return }
        self.addSubview(mealPreppedBtnView)
        self.mealPreppedBtnView?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mealPreppedBtnView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            mealPreppedBtnView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mealPreppedBtnView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            mealPreppedBtnView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06)
        ])
        
        // add button function to mealPreppedBtnView
        self.mealPreppedBtnView?.compileIngredientsBtn?.addTarget(self, action: #selector(self.mealPreppedAction), for: .touchUpInside)
    }
    
    @objc private func mealPreppedAction() {
        guard let menuOption = self.menuOption else { return }
        print("meal kit prepped")
        // mark menu option as being meal kit complete
        self.menuOption?.isMealKitComplete = true
        
        
        // button animation to transition screen
        
        
        // reload the meal kits selection view controller and add to kittedMenuOptions
        self.mealPrepFinishedDelegate?.addToPreppedMeals(menuOption: menuOption)
    }
    

}

protocol MealsPrepCollectionViewCellDelegate: AnyObject {
    func setHeaderViewAlpha(newAlphaValue: CGFloat)
}

extension MealsPrepCollectionViewCell: MealsPrepCollectionViewCellDelegate {
    func setHeaderViewAlpha(newAlphaValue: CGFloat) {
        self.mealsPrepHeaderView.alpha = newAlphaValue
    }
}
