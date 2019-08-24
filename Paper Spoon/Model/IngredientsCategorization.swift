//
//  IngredientsCategorization.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/23/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import Foundation

private class IngredientsCategorization {
    
    enum IngredientsCategory {
        case proteins
        case produce
        case grains
        case dairy
        case fats
        case grocery
        case seasonings
        case undefined
    }
    
    let category: [String:IngredientsCategory] = [
        "Zucchini":.produce,                    "Scallions":.produce,                   "Button Mushrooms":.produce,
        "Carrots":.produce,                     "Ginger":.produce,                      "Garlic":.produce,
        "Jasmine Rice":.grains,                 "White Wine Vinegar":.grocery,          "Sesame Oil":.grocery,
        "Sriracha":.grocery,                    "Soy Sauce":.grocery,                   "Ground Beef":.proteins,
        "Sugar":.grocery,                       "Vegetable Oil":.fats,                  "Salt":.grocery,
        "Pepper":.produce,                      "Grape Tomatoes":.produce,              "Lemon":.produce,
        "Ricotta Cheese":.dairy,                "Flatbreads":.grains,                   "Basil":.produce,
        "Chili Flakes":.seasonings,             "Honey":.grocery,                       "Olive Oil":.fats,
        "Shallot":.produce,                     "Rosemary":.produce,                    "Fig Jam":.grocery,
        "Fingerling Potatoes":.produce,         "Pork Tenderloin":.proteins,            "Green Beans":.produce,
        "Chicken Stock Concentrate":.grocery,   "Balsamic Vinegar":.grocery,            "Butter":.fats,
        "Poblano Pepper":.produce,              "Hot Sauce":.grocery,                   "Sour Cream":.dairy,
        "Chicken Breast Strips":.proteins,      "Southwest Spice Blend":.seasonings,    "Green Salsa":.produce,
        "Mexican Cheese Blend":.dairy,          "Flour Tortillas":.grocery,             "Thai Basil":.produce,
        "Fresh Mozzarella Cheese":.dairy,       "Ground Pork":.proteins,                "Panko Breadcrumbs":.grocery,
        "Parmesan Cheese":.dairy,               "Garlic Powder":.seasonings,            "Marinara Sauce":.grocery,
        "Broccoli Florets":.produce,            "Ciabatta Bread":.grains,               "Cheese Tortelloni":.grocery,
        "Bell Pepper":.produce,                 "Harissa Powder":.seasonings,           "Chickpeas":.grocery,
        "Cracked Bulgur":.grocery,              "Persian Cucumber":.produce,            "Roma Tomato":.produce,
        "Dill":.grocery,                        "Feta Cheese":.dairy,                   "Yukon Gold Potatoes":.produce,
        "Asparagus":.produce,                   "Chives":.produce,                      "Fry Seasoning":.seasonings,
        "Sliced Almonds":.grocery,              "Horseradish Powder":.seasonings,       "Lime":.produce,
        "Milk":.dairy,                          "Vegetable Stock Concentrate":.grocery, "Steelhead Trout":.proteins,
        "Chicken Breasts":.proteins,            "Thyme":.produce,                       "Pork Cutlets":.proteins,
        "Garlic Herb Butter":.dairy,            "Shredded Mozzarella Cheese":.dairy,    "Italian Seasoning":.seasonings,
        "Bacon":.proteins,                      "Dried Thyme":.grocery,                 "Kidney Beans":.grocery,
        "Smoked Paprika":.seasonings,           "Regal Springs Tilapia":.proteins,      "Blackening Spice":.seasonings,
        "Cilantro":.produce,                    "Chili Pepper":.produce,                "Shredded Carrots":.produce,
        "Chicken Cutlets":.proteins,            "Mayonnaise":.dairy,                    "Red Onion":.produce,
        "Pineapple":.produce,                   "Israeli Couscous":.grains,             "Currant Jam":.grocery,
        "Dried Cranberries":.grocery,           "Yellow Onion":.produce,                "Potato Bun":.grains,
        "Ketchup":.grocery,                     "Dijon Mustard":.grocery,               "Cheddar Cheese":.dairy,
        "Italian Chicken Sausage Mix":.proteins,"Cremini Mushrooms":.produce,
        "Gemelli Pasta":.grains,                "Flour":.grocery,                       "Cream Cheese":.dairy,
        "Spaghetti":.grains,                    "Beef Stock Concentrate":.grocery,      "Crushed Tomatoes":.grocery,
    ]
    
}
