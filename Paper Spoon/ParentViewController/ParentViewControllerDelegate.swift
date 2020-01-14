//
//  ParentViewControllerDelegate.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 1/11/20.
//  Copyright © 2020 DLEE. All rights reserved.
//

import UIKit

protocol ParentViewControllerDelegate: AnyObject {
    func changeViewController(index position: Int)
    func sendReducedCompiledIngredients(reducedCompiledIngredients: [Ingredients], completion: (() -> Void))
    func reloadCompiledIngredients()
    func reloadMealPrep()
    func reloadMealKitSelection()
    func setFadeOut(fadeOut: Bool)
    func returnFadeOut() -> Bool
    func fadeTabBar(fadePct: CGFloat)
    func fadeOutSplashImg(fadePct: CGFloat)
}

extension ParentViewController: ParentViewControllerDelegate {
    func changeViewController(index position: Int) {
        self.selectedIndex = position
    }
    
    func sendReducedCompiledIngredients(reducedCompiledIngredients: [Ingredients], completion: (() -> Void)) {
        self.compiledIngredientsViewController.reducedCompiledIngredients = reducedCompiledIngredients
        self.reloadCompiledIngredients()
        self.reloadMealPrep()
        completion()
    }
    
    func reloadCompiledIngredients() {
        self.compiledIngredientsViewController.compiledIngredientsList.reloadData()
    }
    
    func reloadMealPrep() {
        self.mealPrepViewController.mealsPrepCollectionView.reloadData()
    }
    
    func reloadMealKitSelection() {
        self.mealKitSelectionViewController.mealKitsCollectionView.reloadData()
    }
    
    func setFadeOut(fadeOut: Bool) {
        self.fadeOut = fadeOut
    }
    
    func returnFadeOut() -> Bool {
        return self.fadeOut ?? false
    }
    
    func fadeTabBar(fadePct: CGFloat) {
        // return if already faded out
        if self.fadeOut == true && (self.tabBar.alpha) <= 0.0 { return }
        if self.fadeOut == false && (self.tabBar.alpha) >= 1.0 { return }
        
        // calculate alpha
        UIView.animate(withDuration: 0.25) {
            self.tabBar.alpha = fadePct
        }
        
        guard let compileIngredientsButtonCollapsed = self.brandDashboardController.compileIngredientsBtnCollapsed else { return }
        guard let compileIngredientsButtonPopped = self.brandDashboardController.compileIngredientsBtnPopped else { return }
        guard let compileIngredientsButtonCollapsedNoMenu = self.brandDashboardController.compileIngredientsBtnCollapsedNoMenu else { return }
        guard let compileIngredientsButtonPoppedNoMenu = self.brandDashboardController.compileIngredientsBtnPoppedNoMenu else { return }
        
        // evaluate whenever count is > 0
        if self.brandDashboardController.tempSelectedMenuOptions?.count ?? 0 > 0 {
            
            // only shift Popped if activated
            if compileIngredientsButtonPopped.first?.isActive == true || compileIngredientsButtonPoppedNoMenu.first?.isActive == true {
                if self.fadeOut == true {
                    print("REMOVE popped.  ADD popped no tabBar")
                    NSLayoutConstraint.deactivate(compileIngredientsButtonPopped)
                    NSLayoutConstraint.activate(compileIngredientsButtonPoppedNoMenu)
                } else if self.fadeOut == false {
                    print("REMOVE popped no tabBar.  ADD popped")
                    NSLayoutConstraint.deactivate(compileIngredientsButtonPoppedNoMenu)
                    NSLayoutConstraint.activate(compileIngredientsButtonPopped)
                }
            }
            
        } else if self.brandDashboardController.tempSelectedMenuOptions?.count ?? 0 == 0 {
            
            // only shift Collapsed if activated
            if compileIngredientsButtonCollapsed.first?.isActive == true || compileIngredientsButtonCollapsedNoMenu.first?.isActive == true {
                if self.fadeOut == true {
                    print("REMOVE collapsed.  ADD collapsed no tabBar")
                    NSLayoutConstraint.deactivate(compileIngredientsButtonCollapsed)
                    NSLayoutConstraint.activate(compileIngredientsButtonCollapsedNoMenu)
                } else if self.fadeOut == false {
                    print("REMOVE collapsed no tabBar.  ADD collapsed")
                    NSLayoutConstraint.deactivate(compileIngredientsButtonCollapsedNoMenu)
                    NSLayoutConstraint.activate(compileIngredientsButtonCollapsed)
                }
            }
        }
    }
    
    func fadeOutSplashImg(fadePct: CGFloat) {
        // return if already faded out
        if fadePct <= 0 || fadePct >= 1 { return }
        
        self.splashImageView?.alpha = fadePct
    }
}
