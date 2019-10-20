//
//  BrandDashboardControllerViews.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 10/14/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

// MARK: Setting up views
extension BrandDashboardController {
    
    internal func addRecipeListHeader() {
        self.view.addSubview(self.recipeListHeader)
        self.recipeListHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.recipeListHeader.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.recipeListHeader.heightAnchor.constraint(equalToConstant: 100),
            self.recipeListHeader.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
            self.recipeListHeader.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5)
            ])
    }
    
    internal func setupCompileIngredientsBtn() {
        self.compileIngredientsBtn = NextStepBtn(frame: CGRect(x: 0, y: 0,
                                                               width: self.view.frame.width,
                                                               height: self.view.frame.height * 0.1),
                                                 setTitle: "Compile Ingredients!")
        self.compileIngredientsBtn?.addTarget(self, action: #selector(transitionCompileIngredientsView), for: .touchUpInside)
    }
    
    internal func addCompileIngredientsBtn() {
        self.compileIngredientsBtn?.layer.cornerRadius = 5
        self.view.addSubview(self.compileIngredientsBtn ?? UIView())
        
        self.compileIngredientsBtn?.translatesAutoresizingMaskIntoConstraints = false
        self.compileIngredientsBtn?.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        self.compileIngredientsBtn?.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5).isActive = true
        self.compileIngredientsBtn?.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        
        self.compileIngredientsBtnExpanded = self.compileIngredientsBtn?.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1)
        
        self.compileIngredientsBtnHeightCollapsed = self.compileIngredientsBtn?.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.0)
        
        self.compileIngredientsBtnHeightCollapsed?.isActive = true
    }
}


protocol BrandDashboardControllerDelegate: AnyObject {
    func showHideCompileButton()
    func movePickerPosition(position: Int)
}


extension BrandDashboardController: BrandDashboardControllerDelegate {
    
    func showHideCompileButton() {
        guard let compileIngredientsButtonHeightCollapsed = self.compileIngredientsBtnHeightCollapsed else { return }
        if self.menuOptionsObj.selectedMenuOptions.count == 1 {
            if compileIngredientsButtonHeightCollapsed.isActive == true {
                self.compileIngredientsBtnHeightCollapsed?.isActive = false
                self.compileIngredientsBtnExpanded?.isActive = true
                self.recipeListViewController.menuOptionListCollapsed?.isActive = false
                self.recipeListViewController.menuOptionListExpanded?.isActive = true
            }
        } else if self.menuOptionsObj.selectedMenuOptions.count == 0 {
            if compileIngredientsButtonHeightCollapsed.isActive == false {
                self.compileIngredientsBtnExpanded?.isActive = false
                self.compileIngredientsBtnHeightCollapsed?.isActive = true
                self.recipeListViewController.menuOptionListExpanded?.isActive = false
                self.recipeListViewController.menuOptionListCollapsed?.isActive = true
            }
        }
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.9, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func movePickerPosition(position: Int) { }
}
