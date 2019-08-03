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
    var ingredients: Ingredients?
    var instructions: [String]?
    var instructionImageLinks: [String]?
    var thumbnailLink: String?
    var nutrition: Nutrition?
    var description: String?
    
    var instructionImages: [UIImage]?
    var thumbnail: UIImage?
    
    init(name: String?, recipeLink: String?, ingredients: Ingredients?, instructions: [String]?,
         instructionImageLinks: [String]?, thumbnailLink: String?, nutrition: Nutrition?, description: String?) {
        
        self.name = name
        self.recipeLink = recipeLink
        self.ingredients = ingredients
        self.instructions = instructions
        self.instructionImageLinks = instructionImageLinks
        self.thumbnailLink = thumbnailLink
        self.nutrition = nutrition
        self.description = description
    }
}


struct Ingredients {
    var name: String
    var amount: Double
    var measurementType: String
}


struct NutritionValue {
    var amount: Double
    var measurementType: String
}


struct Nutrition {
    var calories: NutritionValue?
    var fatContent: NutritionValue?
    var saturatedFatContent: NutritionValue?
    var carbohydrateContent: NutritionValue?
    var sugarContent: NutritionValue?
    var proteinContent: NutritionValue?
    var fiberContent: NutritionValue?
    var cholesterolContent: NutritionValue?
    var sodiumContent: NutritionValue?
}
