//
//  RecipeCellViews.swift
//  HF Test
//
//  Created by Daniel Lee on 5/13/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

// MARK: - Modifying COLORS of Recipe Cell
extension MealKitsCollectionViewCell {
    
    func modifyColors() {
        self.backgroundSplash.backgroundColor = self.splashColor ?? UIColor.blue
        self.ingredientsButton.backgroundColor = self.splashColor ?? UIColor.blue
        self.likeButton.tintColor = self.splashColor ?? UIColor.blue
        
        // modify nutrition colors
        self.proteinLbl.backgroundColor = self.splashColor ?? UIColor.blue
        self.fatsLbl.backgroundColor = self.splashColor ?? UIColor.blue
        self.carbsLbl.backgroundColor = self.splashColor ?? UIColor.blue
        self.caloriesLbl.backgroundColor = self.splashColor ?? UIColor.blue
        self.protein.backgroundColor = self.splashColor ?? UIColor.blue
        self.fats.backgroundColor = self.splashColor ?? UIColor.blue
        self.carbs.backgroundColor = self.splashColor ?? UIColor.blue
        self.calories.backgroundColor = self.splashColor ?? UIColor.blue
    }
    
}


// MARK: - Modifying view PROPERTIES of Recipe Cell
extension MealKitsCollectionViewCell {
    
    internal func modifyTitle() {
        self.title.textColor = .white
        self.title.font = UIFont.fontBebas?.withSize(40)
    }
    
    internal func modifySubtitle() {
        self.subtitle.textColor = .white
        self.subtitle.font = UIFont.fontBebas?.withSize(15)
    }
    
    internal func modifyDescription() {
        self.recipeDescription.backgroundColor = .white
        self.recipeDescription.textAlignment = .left
        self.recipeDescription.isEditable = false
        self.recipeDescription.textColor = UIColor.black.withAlphaComponent(0.8)
        let descripFontSize = DeviceViews.recipeDescriptionFontSize[Device.current.deviceType] ?? 15
        self.recipeDescription.font = UIFont.fontCoolvetica?.withSize(descripFontSize)
    }
    
    internal func modifyIngredientsBtn() {
        self.ingredientsButton.setImage(UIImage(named: "ingredients_hf.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.ingredientsButton.tintColor = .white
        self.ingredientsButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.ingredientsButton.addTarget(self, action: #selector(self.userPressedIngredients), for: .touchUpInside)
    }
    
    internal func modifyLikeBtn() {
        
        self.likeButton.backgroundColor = .white
        self.likeButton.setImage(UIImage(named: "heart_hf.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.likeButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.likeButton.addTarget(self, action: #selector(self.userPressedLike), for: .touchUpInside)
    }
    
    internal func modifyNutritionStack() {
        self.nutritionStackContainer.backgroundColor = .white
        
        proteinLbl.text = "Protein"
        fatsLbl.text = "Fats"
        carbsLbl.text = "Carbs"
        caloriesLbl.text = "Calories"
        
        // create rounded corners
        proteinLbl.layer.cornerRadius = 2
        fatsLbl.layer.cornerRadius = 2
        carbsLbl.layer.cornerRadius = 2
        caloriesLbl.layer.cornerRadius = 2
        
        proteinLbl.clipsToBounds = true
        fatsLbl.clipsToBounds = true
        carbsLbl.clipsToBounds = true
        caloriesLbl.clipsToBounds = true
        
        proteinLbl.textAlignment = .center
        fatsLbl.textAlignment = .center
        carbsLbl.textAlignment = .center
        caloriesLbl.textAlignment = .center
        
        protein.textAlignment = .center
        fats.textAlignment = .center
        carbs.textAlignment = .center
        calories.textAlignment = .center
        
        // create stackviews
        let labelStackView = UIStackView(arrangedSubviews: [proteinLbl, fatsLbl, carbsLbl, caloriesLbl])
        labelStackView.stackProperties(axis: .horizontal, spacing: 5, alignment: .fill, distribution: .fillEqually)
        
        let dataStackView = UIStackView(arrangedSubviews: [self.protein, self.fats, self.carbs, self.calories])
        dataStackView.stackProperties(axis: .horizontal, spacing: 5, alignment: .fill, distribution: .fillEqually)
        
        let nutritionStackSubviews = [labelStackView, dataStackView]
        let nutritionFontSize = DeviceViews.nutritionFontSize[Device.current.deviceType] ?? 12
        
        for stackView in nutritionStackSubviews {
            for view in stackView.arrangedSubviews {
                if let label = view as? UILabel {
                    label.font = UIFont.fontCoolvetica?.withSize(nutritionFontSize)
                    label.textColor = UIColor.black.withAlphaComponent(0.9)
                }
            }
        }
        
        self.nutritionStack.addArrangedSubview(labelStackView)
        self.nutritionStack.addArrangedSubview(dataStackView)
        self.nutritionStack.stackProperties(axis: .vertical, spacing: -2, alignment: .fill, distribution: .fill)
    }
    
    internal func modifyImage() {
        self.image.contentMode = .scaleAspectFill
        self.image.backgroundColor = .white
        self.image.layer.cornerRadius = (self.frame.width * self.imageWidthMultiplier) / 2
        self.image.layer.borderColor = UIColor.white.cgColor
        self.image.layer.borderWidth = 2
        
        self.image.clipsToBounds = true
        
        self.imageShadow.frame = CGRect(x: 0, y: 0, width: (self.frame.width * self.imageWidthMultiplier), height: (self.frame.width * self.imageWidthMultiplier))
        self.imageShadow.addShadow(path: UIBezierPath(ovalIn: self.imageShadow.layer.bounds),
                                   color: .black,
                                   offset: CGSize(width: 3.0, height: 3.0),
                                   radius: 15,
                                   opacity: 0.5)
    }
    
    internal func modifyRating() {
        self.rating.backgroundColor = .gray
        self.rating.recipeUserInteractionDelegate = self
    }
    
    internal func modifyIngredientsView() {
        let ingredientButtonHeight = (self.frame.width * self.BtnSizeMultiplier) + 15
        self.ingredientsView.headerHeight = ingredientButtonHeight
        self.ingredientsView.alpha = 0.0
    }
    
    internal func modifyGetCookingButton() {
        self.getCookingBtn.setTitle("Show Instructions", for: .normal)
        self.getCookingBtn.titleLabel?.font = UIFont.fontSunflower?.withSize(15)
        self.getCookingBtn.backgroundColor = UIColor.color8
        self.getCookingBtn.layer.cornerRadius = 15
        
        self.getCookingBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.getCookingBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            self.getCookingBtn.heightAnchor.constraint(equalToConstant: 30),
            self.getCookingBtn.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            self.getCookingBtn.bottomAnchor.constraint(equalTo: self.nutritionStackContainer.topAnchor, constant: -15)
        ])
        
        self.getCookingBtn.addTarget(self, action: #selector(self.showInstructions), for: .touchUpInside)
        
        self.getCookingBtn.frame = CGRect(x: 0, y: 0, width: self.frame.width * 0.5, height: 30)
        self.getCookingBtn.addShadow(
            path: UIBezierPath(roundedRect: self.getCookingBtn.layer.bounds, cornerRadius: 15),
            color: .black,
            offset: CGSize(width: 3.0, height: 3.0),
            radius: 15,
            opacity: 0.5)
    }
}
