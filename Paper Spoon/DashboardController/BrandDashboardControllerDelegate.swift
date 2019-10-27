//
//  BrandDashboardControllerDelegate.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 10/20/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

protocol BrandDashboardControllerDelegate: AnyObject {
    func showHideCompileButton()
    func movePickerPosition(position: Int)
    func changeRecipeHeadertext()
    func clearSelections()
}


extension BrandDashboardController: BrandDashboardControllerDelegate {
    
    func showHideCompileButton() {
        guard let compileIngredientsButtonHeightCollapsed = self.compileIngredientsBtnHeightCollapsed else { return }
        if self.menuOptionsObj?.selectedMenuOptions.count == 1 {
            if compileIngredientsButtonHeightCollapsed.isActive == true {
                self.compileIngredientsBtnHeightCollapsed?.isActive = false
                self.compileIngredientsBtnPopped?.isActive = true
                self.compileIngredientsBtnNarrowed?.isActive = false
                self.compileIngredientsBtnExpanded?.isActive = true
                
                self.recipeListViewController.menuOptionListCollapsed?.isActive = false
                self.recipeListViewController.menuOptionListExpanded?.isActive = true
            }
        } else if self.menuOptionsObj?.selectedMenuOptions.count == 0 {
            if compileIngredientsButtonHeightCollapsed.isActive == false {
                self.compileIngredientsBtnPopped?.isActive = false
                self.compileIngredientsBtnHeightCollapsed?.isActive = true
                self.compileIngredientsBtnExpanded?.isActive = false
                self.compileIngredientsBtnNarrowed?.isActive = true
                
                self.recipeListViewController.menuOptionListExpanded?.isActive = false
                self.recipeListViewController.menuOptionListCollapsed?.isActive = true
            }
        }
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.9, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func movePickerPosition(position: Int) { }
    
    func changeRecipeHeadertext() {
        self.recipeListHeader.changeRecipeListHeader(numberOfRecipesSelected: self.menuOptionsObj?.selectedMenuOptions.count ?? 0, maxRecipes: 5)
    }
    
    func clearSelections() {
        self.menuOptionsObj?.selectedMenuOptions.removeAll()
        // clear selection
        if let menuOptions = self.menuOptionsObj?.menuOptions {
            for menuOption in menuOptions {
                menuOption.isSelected = false
            }
        }
        // remove highlighting
        self.recipeListViewController.menuOptionList.reloadData()
        
        // remove button
        self.showHideCompileButton()
        
        self.changeRecipeHeadertext()
    }
    
}
