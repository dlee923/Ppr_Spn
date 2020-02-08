//
//  RecipeCellInteraction.swift
//  HF Test
//
//  Created by Daniel Lee on 5/12/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

protocol RecipeUserInteractionDelegate: MealKitsCollectionViewCell {
    
    func userPressedLike()
    func userPressedIngredients()
    func userPressedRating()
    
}

// MARK: - User Interaction methods
extension MealKitsCollectionViewCell: RecipeUserInteractionDelegate {
    
    @objc internal func userPressedLike() {
        guard let menuOption = self.menuOption else { return }
        
        if let isLiked = self.menuOption?.isLiked {
            if isLiked {
                print("unliked")
                self.favCollectionViewControllerDelegate?.removeFromFavorites(menuOption: menuOption)
                
            } else {
                print("liked")
                self.favCollectionViewControllerDelegate?.addToFavorites(menuOption: menuOption)
            }
            
            // reverse isLiked
            self.menuOption?.isLiked = isLiked ? false : true
            
        } else {
            // If nil then assume false and switch to true
            self.menuOption?.isLiked = true
            
            print("liked")
            self.favCollectionViewControllerDelegate?.addToFavorites(menuOption: menuOption)
        }
        // reload view based on recipe changes
        loadRecipeData()
    }
    
    @objc internal func userPressedIngredients() {
        if let isIngredientsVisible = self.isIngredientsVisible {
            self.isIngredientsVisible = isIngredientsVisible ? false : true
        } else {
            // If nil then assume false and switch to true
            self.isIngredientsVisible = true
        }
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            self.squishBackgroundSplash()
            self.squishImage()
            self.squishLike()
            self.squishIngredientsButton()
            self.squishNutrition()
            self.squishIngredients()
            self.squishGetCookingButton()
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc internal func userPressedRating() {
        if let rating = self.rating.rating {
            // Set recipe object rating here
            self.menuOption?.userRating = rating
            // Command view controller to send rating to server
            
            print(rating)
            
        }
    }
    
}
