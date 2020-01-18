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
        
        self.compileIngredientsView.backgroundColor = UIColor.themeColor1.withAlphaComponent(0.7)
        self.compileIngredientsView.translatesAutoresizingMaskIntoConstraints = false
        
        self.compileIngredientsBtnPopped = [
            self.compileIngredientsView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05),
            self.compileIngredientsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.compileIngredientsView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.compileIngredientsView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0, constant: -10)
        ]
        
        self.compileIngredientsBtnPoppedNoMenu = [
            self.compileIngredientsView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05),
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
    }
    
    internal func setupCompileIngredientsBtn() {
        self.compileIngredientsBtn = NextStepBtn(frame: CGRect(x: 0, y: 0,
                                                               width: (self.view.frame.height * 0.05) - 20,
                                                               height: (self.view.frame.height * 0.05) - 20),
                                                 setTitle: "Create Shopping List!")
        self.compileIngredientsBtn?.titleLabel?.font = UIFont.fontSunflower?.withSize(12)
        self.compileIngredientsBtn?.titleLabel?.numberOfLines = 2
        self.compileIngredientsBtn?.titleLabel?.textAlignment = .center
        self.compileIngredientsBtn?.addTarget(self, action: #selector(transitionCompileIngredientsView), for: .touchUpInside)
        
        self.compileIngredientsBtn?.layer.cornerRadius = ((self.compileIngredientsBtn?.frame.height ?? 0) / 2)
    }
    
    internal func addCompileIngredientsBtn() {
        guard let compileIngredientsBtn = self.compileIngredientsBtn else { return }
        self.compileIngredientsView.addSubview(compileIngredientsBtn)
        
        compileIngredientsBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            compileIngredientsBtn.topAnchor.constraint(equalTo: self.compileIngredientsView.topAnchor),
            compileIngredientsBtn.centerXAnchor.constraint(equalTo: self.compileIngredientsView.centerXAnchor),
            compileIngredientsBtn.bottomAnchor.constraint(equalTo: self.compileIngredientsView.bottomAnchor, constant: -5),
            compileIngredientsBtn.widthAnchor.constraint(equalTo: self.compileIngredientsView.widthAnchor, multiplier: 0.5)
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
        
        fingerTrailingAnchorClose = finger.trailingAnchor.constraint(equalTo: compileIngredientsBtn.leadingAnchor, constant: -15)
        fingerTrailingAnchorFar = finger.trailingAnchor.constraint(equalTo: compileIngredientsBtn.leadingAnchor, constant: -30)
        fingerTrailingAnchorClose?.isActive = true
    }
    
}

