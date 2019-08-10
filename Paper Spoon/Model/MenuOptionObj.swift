//
//  MenuObject.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/10/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class MenuOptionObj {
    var menuOptions: [MenuOption]?
    
    init(menuOptions: [MenuOption]?) {
        self.menuOptions = menuOptions
    }
}


struct MenuOption {
    var recipeName: String
    var recipeLink: String
    var recipe: Recipe?
//    {
//        didSet {
//            if let thumbnaillink = recipe?.thumbnailLink {
//                ImageAPI.shared.downloadImage(urlLink: thumbnaillink) { (thumbnail) in
//                    self.recipe?.thumbnail = UIImage(data: thumbnail)
//                }
//            }
//        }
//    }
//    
//    init(recipeName: String, recipeLink: String, recipe: Recipe?) {
//        self.recipeName = recipeName
//        self.recipeLink = recipeLink
//        self.recipe = recipe
//    }
}
