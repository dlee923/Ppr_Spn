//
//  BrandDashboardControllerLogic.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 1/23/20.
//  Copyright © 2020 DLEE. All rights reserved.
//

import Foundation

extension BrandDashboardController {
    
    internal func calculateIngredients(completion: () -> ()) {
        // aggregate all ingredients from selected recipes
        guard let selectedMenuOptions = self.menuOptionsObj?.selectedMenuOptions else { return }
        
        // reset compiledIngredients
        self.compiledIngredients.removeAll()
        
        // add each individual ingredient from each recipe to a container
        for menuOption in selectedMenuOptions {
            if let recipeIngredients = menuOption.recipe?.ingredients {
                let ingredientsToAdd = recipeIngredients
                self.compiledIngredients += ingredientsToAdd
            }
        }
        
        // standardize ingredient measurements
        
        // standardize ingredient names ?? if allowing cross brand.
        
        
        // reduce ingredients list to just unique values based on name only
        reducedCompiledIngredients = compiledIngredients.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
        
        // modify ingredients list amounts based on original compiledIngredients list
        for ingredient in self.reducedCompiledIngredients {
            let ingredientToReduce = self.compiledIngredients.filter({ $0.name == ingredient.name })
            if let startingIngredientAmount = ingredientToReduce.first?.amount {
                let totalIngredientAmount = ingredientToReduce.reduce(startingIngredientAmount, { $0 + ($1.amount ?? 0) })
                ingredient.amount = totalIngredientAmount
                
                print(ingredient.name)
            }
            
        }
        
        completion()
    }
    
}
