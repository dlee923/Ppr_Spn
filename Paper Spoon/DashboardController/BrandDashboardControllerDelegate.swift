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
    func minimizeBrandsCollectionView(scrollPositionY: CGFloat)
    func lockUnlockScrollView()
}


extension BrandDashboardController: BrandDashboardControllerDelegate {
    
    func showHideCompileButton() {
        guard let compileIngredientsButtonCollapsed = self.compileIngredientsBtnCollapsed else { return }
        guard let compileIngredientsButtonPopped = self.compileIngredientsBtnPopped else { return }
        guard let compileIngredientsButtonCollapsedNoMenu = self.compileIngredientsBtnCollapsedNoMenu else { return }
        guard let compileIngredientsButtonPoppedNoMenu = self.compileIngredientsBtnPoppedNoMenu else { return }
        
        if self.tempSelectedMenuOptions?.count == 1 {
            
            // only activate Popped if not already activated
            if compileIngredientsButtonCollapsed.first?.isActive == true {
                if self.parentViewControllerDelegate?.returnFadeOut() == true {
                    NSLayoutConstraint.deactivate(compileIngredientsButtonCollapsedNoMenu)
                    NSLayoutConstraint.activate(compileIngredientsButtonPoppedNoMenu)
                } else if self.parentViewControllerDelegate?.returnFadeOut() == false {
                    NSLayoutConstraint.deactivate(compileIngredientsButtonCollapsed)
                    NSLayoutConstraint.activate(compileIngredientsButtonPopped)
                }
                
                self.helloFreshViewController.menuOptionListCollapsed?.isActive = false
                self.helloFreshViewController.menuOptionListExpanded?.isActive = true
                
                self.blueApronViewController.menuOptionListCollapsed?.isActive = false
                self.blueApronViewController.menuOptionListExpanded?.isActive = true
                
                self.homeChefViewController.menuOptionListCollapsed?.isActive = false
                self.homeChefViewController.menuOptionListExpanded?.isActive = true
            }
            
        } else if self.tempSelectedMenuOptions?.count == 0 {
            
            // only activate Collasped if not already activated
            if compileIngredientsButtonCollapsed.first?.isActive == false {
                if self.parentViewControllerDelegate?.returnFadeOut() == true {
                    NSLayoutConstraint.deactivate(compileIngredientsButtonPoppedNoMenu)
                    NSLayoutConstraint.activate(compileIngredientsButtonCollapsedNoMenu)
                } else if self.parentViewControllerDelegate?.returnFadeOut() == false {
                    NSLayoutConstraint.deactivate(compileIngredientsButtonPopped)
                    NSLayoutConstraint.activate(compileIngredientsButtonCollapsed)
                }
                
                self.helloFreshViewController.menuOptionListExpanded?.isActive = false
                self.helloFreshViewController.menuOptionListCollapsed?.isActive = true
                
                self.blueApronViewController.menuOptionListExpanded?.isActive = false
                self.blueApronViewController.menuOptionListCollapsed?.isActive = true
                
                self.homeChefViewController.menuOptionListExpanded?.isActive = false
                self.homeChefViewController.menuOptionListCollapsed?.isActive = true
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
            for (key, value) in menuOptions {
                if let brandMenuOptions = menuOptions[key] {
                    for menuOption in brandMenuOptions {
                        menuOption.isSelected = false
                    }
                }
            }
        }
        
        // remove highlighting
        for brandViewController in self.controllers {
            if let brandVC = brandViewController as? BrandViewController {
                brandVC.menuOptionList.reloadData()
            }
        }
        
        // remove button
        self.showHideCompileButton()
        
        self.changeRecipeHeadertext()
    }
    
    func selectMenuOption(menuOption: MenuOption) {
        // create array if nil
        if self.tempSelectedMenuOptions == nil { self.tempSelectedMenuOptions = [MenuOption]() }
        
        // check if menuOptionObj exists in selectedMenuOptions and remove otherwise add to array
        if let alreadySelectedIndex = self.tempSelectedMenuOptions?.firstIndex(where: { $0.recipeName == menuOption.recipeName }) {
            
            self.tempSelectedMenuOptions?.remove(at: alreadySelectedIndex)
            
            // mark as not selected for prepareForReuse
            menuOption.isSelected = false
        } else {
            
            // return if already at max options count
            if self.tempSelectedMenuOptions?.count ?? 0 >= self.recipeMaxCount { return }
            
            self.tempSelectedMenuOptions?.append(menuOption)
            
            // mark as selected for prepareForReuse
            menuOption.isSelected = true
        }
    }
    
    func isMaxedOut() -> Bool {
        // return if max selection is hit
        let response = self.tempSelectedMenuOptions?.count ?? 0 >= self.recipeMaxCount ? true : false
        return response
    }
    
    func minimizeBrandsCollectionView(scrollPositionY: CGFloat) {
        // calculate point at which push should occur
        self.moveRecipeHeaderTrigger = scrollPositionY + self.recipeHeaderHeightConstant + headerBuffer - verticalSpacer
        
        guard let moveRecipeHeaderTrigger = self.moveRecipeHeaderTrigger else { return }
        
        if moveRecipeHeaderTrigger > 0 && moveRecipeHeaderTrigger < maxVerticalSpacer {
            // move recipeheader up or down
            recipeListHeaderTopConstraint?.constant = -moveRecipeHeaderTrigger
            
            // set properties back to default
            self.recipeListHeader.headerLabel.font = self.recipeListHeader.headerLabel.font.withSize(30)
            self.recipeListHeader.brandsPickerView.alpha = 1.0
            self.recipeListHeader.blurView.alpha = 0
            self.recipeListHeader.headerLabel.textColor = UIColor.themeColor1
            self.recipeListHeader.headerLabel.layer.shadowColor = UIColor.black.cgColor
            self.view.layoutIfNeeded()
            
        } else if moveRecipeHeaderTrigger >= maxVerticalSpacer {
            // stop recipeHeader movement up
            recipeListHeaderTopConstraint?.constant = -maxVerticalSpacer
            self.view.layoutIfNeeded()
            
            // adjust size of text label
            self.newFontSize = 30 - (moveRecipeHeaderTrigger - maxVerticalSpacer)
            guard let newFontSize = self.newFontSize else { return }
            
            if newFontSize < 20 {
                self.newFontSize = 20
            } else if newFontSize > 30 {
                self.newFontSize = 30
            }
            
            // change recipeHeader font size
            self.recipeListHeader.headerLabel.font = self.recipeListHeader.headerLabel.font.withSize(self.newFontSize ?? 30)
            
            // fade out brandsPickerView
            let brandsPickerViewAlpha = 1 - ((30 - newFontSize) / (30 - 20))
            self.recipeListHeader.brandsPickerView.alpha = brandsPickerViewAlpha
            
            if moveRecipeHeaderTrigger >= maxVerticalSpacer + blurStartPoint {
                let blurViewDistance = moveRecipeHeaderTrigger - (maxVerticalSpacer + blurStartPoint) >= 50 ? 50 : moveRecipeHeaderTrigger - (maxVerticalSpacer + blurStartPoint)
                let blurViewAlpha = (blurViewDistance / 50) * 0.75
                self.recipeListHeader.blurView.alpha = blurViewAlpha
                self.recipeListHeader.headerLabel.textColor = blurViewAlpha >= 0.75 ? UIColor.themeColor2 : UIColor.themeColor1
                self.recipeListHeader.headerLabel.layer.shadowColor = blurViewAlpha >= 0.75 ? UIColor.clear.cgColor : UIColor.black.cgColor
            }
            
        } else {
            // stop recipeHeader movement down
            recipeListHeaderTopConstraint?.constant = 0
            // set properties back to default
            self.recipeListHeader.headerLabel.font = self.recipeListHeader.headerLabel.font.withSize(30)
            self.recipeListHeader.brandsPickerView.alpha = 1.0
            self.recipeListHeader.blurView.alpha = 0
            self.recipeListHeader.headerLabel.textColor = UIColor.themeColor1
            self.recipeListHeader.headerLabel.layer.shadowColor = UIColor.black.cgColor
            self.view.layoutIfNeeded()
        }
    }
    
    func lockUnlockScrollView() {
        if self.tempSelectedMenuOptions?.count == 1 {
            // by removing data source
            self.dataSource = nil
        } else if self.tempSelectedMenuOptions?.count == 0 {
            // by removing data source
            self.dataSource = self
        }
    }
    
}


protocol BrandDashboardControllerTransitionsDelegate: AnyObject {
    func transitionCompileIngredientsViewDelegateMethod()
}

extension BrandDashboardController: BrandDashboardControllerTransitionsDelegate {
    func transitionCompileIngredientsViewDelegateMethod() {
        self.transitionCompileIngredientsView()
    }
    
}

