//
//  RecipeModel.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/2/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class Recipe {
    
    var name: String?
    var recipeLink: String?
    var ingredients: [Ingredients]?
    var instructions: [String]?
    var instructionImageLinks: [String]?
    var recipeImageLink: String?
    var thumbnailLink: String?
    var nutrition: Nutrition?
    var description: String?
    
    var instructionImages: [UIImage]?
    var thumbnail: UIImage?
    var recipeImage: UIImage?
    var ingredientImageLinks: [String: String]?
    
    init(name: String?, recipeLink: String?, ingredients: [Ingredients]?, instructions: [String]?,
         instructionImageLinks: [String]?, ingredientImageLinks: [String: String]?, recipeImageLink: String?, thumbnailLink: String?, nutrition: Nutrition?, description: String?) {
        
        self.name = name
        self.recipeLink = recipeLink
        self.ingredients = ingredients
        self.instructions = instructions
        self.instructionImageLinks = instructionImageLinks
        self.recipeImageLink = recipeImageLink
        self.thumbnailLink = thumbnailLink
        self.nutrition = nutrition
        self.description = description
        self.ingredientImageLinks = ingredientImageLinks
    }
}
