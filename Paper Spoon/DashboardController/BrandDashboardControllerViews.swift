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
            self.recipeListHeader.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
            self.recipeListHeader.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5)
        ])
        self.recipeHeaderHeight = self.recipeListHeader.heightAnchor.constraint(equalToConstant: self.recipeHeaderHeightConstant)
        self.recipeHeaderHeight?.isActive = true
    }
    
    internal func addCompileIngredientsView() {
        self.view.addSubview(self.compileIngredientsView)
        
        self.compileIngredientsView.translatesAutoresizingMaskIntoConstraints = false
        self.compileIngredientsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true

        self.compileIngredientsView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.compileIngredientsView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0, constant: -10).isActive = true
        
        self.compileIngredientsBtnPopped = self.compileIngredientsView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1)
        self.compileIngredientsBtnHeightCollapsed = self.compileIngredientsView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.0)
//        self.compileIngredientsBtnHeightCollapsed?.isActive = true
        self.compileIngredientsBtnPopped?.isActive = true
    }
    
    internal func setupCompileIngredientsBtn() {
        self.compileIngredientsBtn = NextStepBtn(frame: CGRect(x: 0, y: 0,
                                                               width: self.view.frame.width * 0.1,
                                                               height: self.view.frame.height * 0.1),
                                                 setTitle: "Create Shopping List!")
        self.compileIngredientsBtn?.titleLabel?.font = UIFont.fontSunflower?.withSize(14)
        self.compileIngredientsBtn?.titleLabel?.numberOfLines = 2
        self.compileIngredientsBtn?.titleLabel?.textAlignment = .center
        self.compileIngredientsBtn?.addTarget(self, action: #selector(transitionCompileIngredientsView), for: .touchUpInside)
        
        self.compileIngredientsBtn?.layer.cornerRadius = (self.compileIngredientsBtn?.frame.height ?? 0) / 2
    }
    
    internal func addCompileIngredientsBtn() {
        guard let compileIngredientsBtn = self.compileIngredientsBtn else { return }
        self.compileIngredientsView.addSubview(compileIngredientsBtn)
        
        compileIngredientsBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            compileIngredientsBtn.topAnchor.constraint(equalTo: self.compileIngredientsView.topAnchor),
            compileIngredientsBtn.trailingAnchor.constraint(equalTo: self.compileIngredientsView.trailingAnchor),
            compileIngredientsBtn.bottomAnchor.constraint(equalTo: self.compileIngredientsView.bottomAnchor),
            compileIngredientsBtn.widthAnchor.constraint(equalTo: self.compileIngredientsView.heightAnchor)
        ])
    }
    
    internal func addFingerPointer() {
        guard let compileIngredientsBtn = self.compileIngredientsBtn else { return }
        let finger = UIImageView(image: UIImage(named: "hand"))
        finger.contentMode = .scaleAspectFit
        self.compileIngredientsView.addSubview(finger)
        
        finger.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            finger.topAnchor.constraint(equalTo: self.compileIngredientsView.topAnchor),
            finger.bottomAnchor.constraint(equalTo: self.compileIngredientsView.bottomAnchor),
            finger.widthAnchor.constraint(equalTo: self.compileIngredientsView.widthAnchor, multiplier: 0.1)
        ])
        
        fingerTrailingAnchorClose = finger.trailingAnchor.constraint(equalTo: compileIngredientsBtn.leadingAnchor, constant: -5)
        fingerTrailingAnchorFar = finger.trailingAnchor.constraint(equalTo: compileIngredientsBtn.leadingAnchor, constant: -20)
        fingerTrailingAnchorClose?.isActive = true
    }
}

