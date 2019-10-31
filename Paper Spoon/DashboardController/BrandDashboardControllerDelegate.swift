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
    func selectMenuOption(menuOption: MenuOption)
    func isMaxedOut() -> Bool
}


extension BrandDashboardController: BrandDashboardControllerDelegate {
    
    func showHideCompileButton() {
        guard let compileIngredientsButtonHeightCollapsed = self.compileIngredientsBtnHeightCollapsed else { return }
        if self.tempSelectedMenuOptions?.count == 1 {
            if compileIngredientsButtonHeightCollapsed.isActive == true {
                self.compileIngredientsBtnHeightCollapsed?.isActive = false
                self.compileIngredientsBtnPopped?.isActive = true
                self.compileIngredientsBtnNarrowed?.isActive = false
                self.compileIngredientsBtnExpanded?.isActive = true
                
                self.recipeListViewController.menuOptionListCollapsed?.isActive = false
                self.recipeListViewController.menuOptionListExpanded?.isActive = true
            }
        } else if self.tempSelectedMenuOptions?.count == 0 {
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
        self.recipeListHeader.changeRecipeListHeader(numberOfRecipesSelected: self.tempSelectedMenuOptions?.count ?? 0, maxRecipes: self.recipeMaxCount)
    }
    
    func clearSelections() {
        self.tempSelectedMenuOptions?.removeAll()
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
    
    func selectMenuOption(menuOption: MenuOption) {
        // return if already at max options count
        if self.tempSelectedMenuOptions?.count ?? 0 >= self.recipeMaxCount { return }
        
        // create array if nil
        if self.tempSelectedMenuOptions == nil { self.tempSelectedMenuOptions = [MenuOption]() }
        
        // check if menuOptionObj exists in selectedMenuOptions and remove otherwise add to array
        if let alreadySelectedIndex = self.tempSelectedMenuOptions?.firstIndex(where: { $0.recipeName == menuOption.recipeName }) {
            self.tempSelectedMenuOptions?.remove(at: alreadySelectedIndex)
            
            // mark as not selected for prepareForReuse
            menuOption.isSelected = false
        } else {
            self.tempSelectedMenuOptions?.append(menuOption)
            
            // mark as selected for prepareForReuse
            menuOption.isSelected = true
        }
    }
    
    func isMaxedOut() -> Bool {
        // return if max selection is hit
        let response = self.tempSelectedMenuOptions?.count ?? 0 > self.recipeMaxCount ? true : false
        return response
    }
    
}
