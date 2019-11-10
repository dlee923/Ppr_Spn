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


class Ingredients: Equatable {
    var name: String
    var amount: Double?
    var measurementType: String?
    var isPacked: Bool?
    
    var imageLink: String?
    var image: UIImage?
    
    // confirm to Equatable protocol
    static func == (lhs: Ingredients, rhs: Ingredients) -> Bool {
        return lhs.name == rhs.name
    }
    
    init (name: String, amount: Double?, measurementType: String?, isPacked: Bool?, imageLink: String?, image: UIImage?) {
        self.name = name
        self.amount = amount
        self.measurementType = measurementType
        self.isPacked = isPacked
        self.imageLink = imageLink
        self.image = image
    }
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
