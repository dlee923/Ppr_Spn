//
//  BrandDashboardControllerTransitions.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 1/23/20.
//  Copyright © 2020 DLEE. All rights reserved.
//

import UIKit

extension BrandDashboardController {
    
    // button action to proceed to shopping list screen
    @objc internal func transitionCompileIngredientsView() {
        if self.menuOptionsObj?.menuOptions == nil {
            // prompt warning?
            return
        }
        
        guard let temporarySelectedMenuOptions = self.tempSelectedMenuOptions else { return }
        
        if temporarySelectedMenuOptions.count <= 0 { return }
        
        self.menuOptionsObj?.selectedMenuOptions = temporarySelectedMenuOptions
        
        // inject compiled ingredients list
        self.calculateIngredients {
            
            // find number of ingredients that only have a picture source
            let reducedCompiledIngredientsCount = self.reducedCompiledIngredients.filter({ $0.imageLink != nil }).count
            let selectedMenuOptionsCount = self.menuOptionsObj?.selectedMenuOptions.filter({ $0.recipe?.recipeImageLink != nil }).count ?? 0
            
            // reset work item completions:
            self.workItemCompletionCount = 0
            self.workItemCompletionLimit = reducedCompiledIngredientsCount + selectedMenuOptionsCount
            
            // download ingredients images
            self.downloadIngredientImages()
            
            // download recipe images
            self.downloadRecipeImages()
            
            dispatchGroup.notify(queue: mainThread, execute: {
                self.parentViewControllerDelegate?.sendReducedCompiledIngredients(reducedCompiledIngredients: self.reducedCompiledIngredients, completion: {
                    // attach ingredient images to MenuOption recipe ingredient images
                    self.allocateIngredientImages()
                    
                    // present compiledIngredientsViewController
                    self.activityIndicator.activityEnded()
                    self.parentViewControllerDelegate?.changeViewController(index: 1)
                })
            })
        }
        
        // animate tab bar back into view
        self.parentViewControllerDelegate?.fadeTabBar(fadePct: 1.0)
    }
    
    // prompt creating menu name
    @objc internal func createNewMenuPrompt() {
        let newMenuPrompt = NewMenuPrompt()
        newMenuPrompt.brandDashboardControllerTransitionsDelegate = self
        newMenuPrompt.translatesAutoresizingMaskIntoConstraints = false
        newMenuPromptPopped = [
            newMenuPrompt.topAnchor.constraint(equalTo: self.view.topAnchor),
            newMenuPrompt.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            newMenuPrompt.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            newMenuPrompt.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        
        newMenuPromptCollapsed = [
            newMenuPrompt.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            newMenuPrompt.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            newMenuPrompt.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5),
            newMenuPrompt.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5)
        ]
        
        self.view.addSubview(newMenuPrompt)
        
        guard let newMenuPromptCollapsed = self.newMenuPromptCollapsed else { return }
        NSLayoutConstraint.activate(newMenuPromptCollapsed)
        newMenuPrompt.alpha = 0.2
        
        self.view.layoutIfNeeded()
        
        guard let newMenuPromptPopped = self.newMenuPromptPopped else { return }
        NSLayoutConstraint.deactivate(newMenuPromptCollapsed)
        NSLayoutConstraint.activate(newMenuPromptPopped)
        
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.9, options: .curveEaseOut, animations: {
            newMenuPrompt.alpha = 1.0
            
            self.view.layoutIfNeeded()
        }, completion: { (_) in
            
        })
        
        // animate tab bar back into view
        self.parentViewControllerDelegate?.fadeTabBar(fadePct: 1.0)
    }
    
}