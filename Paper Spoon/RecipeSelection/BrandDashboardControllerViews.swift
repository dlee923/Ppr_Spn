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
            self.recipeListHeader.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
            self.recipeListHeader.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            self.recipeListHeader.heightAnchor.constraint(equalToConstant: self.recipeHeaderHeightConstant)
        ])
        
        self.recipeListHeaderTopConstraint = self.recipeListHeader.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0)
        
        self.recipeListHeaderTopConstraint?.isActive = true
    }
    
    internal func addCompileIngredientsView() {
        self.view.addSubview(self.compileIngredientsView)
        
        self.compileIngredientsView.backgroundColor = UIColor.themeColor1
        self.compileIngredientsView.compileIngredientsBtn?.addTarget(self, action: #selector(transitionCompileIngredientsView), for: .touchUpInside)
        
        self.compileIngredientsView.translatesAutoresizingMaskIntoConstraints = false
        
        self.compileIngredientsBtnPopped = [
            self.compileIngredientsView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: self.compileIngredientsView.compileIngredientsBtnHeight),
            self.compileIngredientsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.compileIngredientsView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.compileIngredientsView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0, constant: -10)
        ]
        
        self.compileIngredientsBtnPoppedNoMenu = [
            self.compileIngredientsView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: self.compileIngredientsView.compileIngredientsBtnHeight),
            self.compileIngredientsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
            self.compileIngredientsView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.compileIngredientsView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0, constant: -10)
        ]
        
        self.compileIngredientsBtnCollapsed = [
            self.compileIngredientsView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.0),
            self.compileIngredientsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.compileIngredientsView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.compileIngredientsView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0, constant: -10)
        ]
        
        self.compileIngredientsBtnCollapsedNoMenu = [
            self.compileIngredientsView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.0),
            self.compileIngredientsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
            self.compileIngredientsView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.compileIngredientsView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0, constant: -10)
        ]
        
        if let compileIngredientsBtnCollapsedConstraints = self.compileIngredientsBtnCollapsed {
            NSLayoutConstraint.activate(compileIngredientsBtnCollapsedConstraints)
            print("ADD collapsed.")
        }
        
        // hide
        self.compileIngredientsView.isHidden = true
        
//        if let compileIngredientsBtnCollapsedPopped = self.compileIngredientsBtnPopped {
//            NSLayoutConstraint.activate(compileIngredientsBtnCollapsedPopped)
//            print("ADD Popped.")
//        }
    }
    
}

