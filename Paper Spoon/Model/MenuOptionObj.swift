//
//  MenuObject.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/10/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class MenuOptionObj {
    var menuOptions = [BrandType: [MenuOption]]()
    var selectedMenuOptions = [MenuOption]()
    var kittedMenuOptions = [MenuOption]()
    
    func menuOptionKittedComplete(for menuOption: MenuOption) {
        // add menuOption to kittedMenuOption
        self.kittedMenuOptions.append(menuOption)
        
        // remove menuOption from selectedMenuOptions
        self.selectedMenuOptions.removeAll(where: { $0.recipeName == menuOption.recipeName })
    }
    
    init(menuOptions: [BrandType: [MenuOption]]?) {
        if let menuOptions_ = menuOptions {
            self.menuOptions = menuOptions_
        }
    }
}


class MenuOption {
    var recipeName: String
    var recipeLink: String
    var recipe: Recipe?
    var recipeSubtitle: String
    var isSelected: Bool?
    var isMealKitComplete: Bool?
    var brandType: BrandType
    
    var isLiked: Bool?
    var userRating: Int?
    
    init(recipeName: String, recipeLink: String, recipe: Recipe?, recipeSubtitle: String, brandType: BrandType) {
        self.recipeName = recipeName
        self.recipeLink = recipeLink
        if let recipe0 = recipe {
            self.recipe = recipe0
        }
        self.recipeSubtitle = recipeSubtitle
        self.brandType = brandType
    }
}
