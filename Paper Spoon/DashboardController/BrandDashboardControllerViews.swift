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
//        self.compileIngredientsBtn?.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5).isActive = true
//        self.compileIngredientsBtn?.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        self.compileIngredientsBtn?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.compileIngredientsBtnPopped = self.compileIngredientsBtn?.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1)
        self.compileIngredientsBtnHeightCollapsed = self.compileIngredientsBtn?.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.0)
        self.compileIngredientsBtnHeightCollapsed?.isActive = true
        
        self.compileIngredientsBtnExpanded = self.compileIngredientsBtn?.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0, constant: -10)
        self.compileIngredientsBtnNarrowed = self.compileIngredientsBtn?.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0)
        self.compileIngredientsBtnNarrowed?.isActive = true
    }
}

