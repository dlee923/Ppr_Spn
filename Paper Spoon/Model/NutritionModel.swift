//
//  NutritionModel.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 1/25/20.
//  Copyright © 2020 DLEE. All rights reserved.
//

import Foundation

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

struct NutritionValue {
    var amount: Double
    var measurementType: String
}
