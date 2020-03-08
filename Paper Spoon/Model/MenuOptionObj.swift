//
//  MenuObject.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/10/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class MenuOptionObj{
    
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


class MenuOption: NSObject, NSCoding {
    
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
    
    // assign a key for items to be saved
    func encode(with coder: NSCoder) {
        coder.encode(recipeName, forKey: "recipeName")
        coder.encode(recipeLink, forKey: "recipeLink")
        coder.encode(recipeSubtitle, forKey: "recipeSubtitle")
        coder.encode(brandType.rawValue, forKey: "brandType")
    }
    
    // load object with saved data
    required convenience init?(coder: NSCoder) {
        let recipeName = coder.decodeObject(forKey: "recipeName") as? String ?? ""
        let recipeLink = coder.decodeObject(forKey: "recipeLink") as? String ?? ""
        let recipeSubtitle = coder.decodeObject(forKey: "recipeSubtitle") as? String ?? ""
        let brandTypeString = coder.decodeObject(forKey: "brandType") as? String ?? ""
        
        var brandType: BrandType?
        
        switch brandTypeString {
        case "HelloFresh" : brandType = .HelloFresh
        case "BlueApron" : brandType = .BlueApron
        case "HomeChef" : brandType = .HomeChef
        case "Plated" : brandType = .Plated
        default : break
        }
        
        self.init(recipeName: recipeName, recipeLink: recipeLink, recipe: nil, recipeSubtitle: recipeSubtitle, brandType: brandType ?? .HelloFresh)
    }
    
}
