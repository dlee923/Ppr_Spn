//
//  HelloFreshScrape.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 11/11/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import Foundation

struct MenuOption {
    var recipeName: String
    var recipeLink: String
}

struct Ingredients {
    var name: String
    var amount: Double
    var measurementType: String
}

class HelloFreshScrapeAPI: NSObject {
    
    func retrieveMenuOptions() {
//        let urlString = "https://www.hellofresh.com/menus/"
        let urlString = "https://www.hellofresh.com/recipes/italian-meatloaf-5d07d08ca79ba000160eed63"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print(err)
            }
            if let htmlData = data {
//                self.parseMenuOptions(htmlData: htmlData)
//                self.parseMenuIngredients(htmlData: htmlData)
//                self.parseRecipeInstructions(htmlData: htmlData)
//                self.parseRecipeNutrition(htmlData: htmlData)
//                self.parseRecipeTitle(htmlData: htmlData)
//                self.parseRecipeDescription(htmlData: htmlData)
                self.parseRecipeThumbnail(htmlData: htmlData)
            }
        }.resume()
    }
    
    
    // Retrieve recipe MENU OPTIONS
    func parseMenuOptions(htmlData: Data) {
        // create container to store menu options
        var menuOptions = [MenuOption]()
        
        // parse html code here
        let htmlCode = String(data: htmlData, encoding: String.Encoding.utf8)
//        print(htmlCode)
        
        guard let recipeLinks = htmlCode?.components(separatedBy: ",category") else { return }
        
        for x in 0..<(recipeLinks.count - 1) {
            let link = recipeLinks[x].components(separatedBy: ",label")
            if link.count > 1 {
                let recipeInfo = link.first
                
                // parse recipe name
                let recipeNameSection0 = recipeInfo?.components(separatedBy: "author:").last
                let recipeNameSection1 = recipeNameSection0?.components(separatedBy: "name:")[1]
                let recipeName = recipeNameSection1?.components(separatedBy: ",slug:").first ?? ""
                
                // parse recipe link
                let recipeLink = recipeInfo?.components(separatedBy: "websiteUrl:\"").last ?? ""
                
                // create menu option
                let menuOption = MenuOption(recipeName: recipeName, recipeLink: recipeLink)
                menuOptions.append(menuOption)
            }
        }
        for menuOption in menuOptions {
            print(menuOption.recipeName)
            print(menuOption.recipeLink)
            print()
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            print()
        }
    }
    
    
    // Retrieve recipe INGREDIENTS
    func parseMenuIngredients(htmlData: Data) {
        // create container to store ingredients
        var ingredients = [String]()
        
        // parse html code here
        let htmlCode = String(data: htmlData, encoding: String.Encoding.utf8)
//        print(htmlCode)

        let ingredientSection0 = htmlCode?.components(separatedBy: "recipeIngredient").last
        let ingredientSection1 = ingredientSection0?.components(separatedBy: "recipeYield").first
        let ingredientSection2 = ingredientSection1?.components(separatedBy: ":[").last
        let ingredientSection3 = ingredientSection2?.components(separatedBy: "]").first
        
        let ingredientList = ingredientSection3?.components(separatedBy: ",") ?? [String]()
    }
    
    
    // Retrieve recipe INSTRUCTIONS
    func parseRecipeInstructions(htmlData: Data) {
        // create container to store instructions
        var instructions = [String]()
        
        // parse html code here
        let htmlCode = String(data: htmlData, encoding: String.Encoding.utf8)
//            print(htmlCode)
        
        let instructionsSection0 = htmlCode?.components(separatedBy: "recipeInstructions").last
        
        let instructionsSection1 = instructionsSection0?.components(separatedBy: "recipeIngredient").first
        let instructionsSection2 = instructionsSection1?.components(separatedBy: "text\":\"") ?? [String]()
        for instructionBlock in instructionsSection2 {
            let instruction = instructionBlock.components(separatedBy: "\"}").first ?? ""
            instructions.append(instruction)
        }
        
        instructions.removeFirst()
        
        for instruction in instructions {
            print(instruction)
        }
    }
    
    
    // Retrieve recipe NUTRITION
    func parseRecipeNutrition(htmlData: Data) {
        // create container to store nutrition
        var nutrition = [String]()
        
        // parse html code here
        let htmlCode = String(data: htmlData, encoding: String.Encoding.utf8)
//            print(htmlCode)
        
        let nutritionSection0 = htmlCode?.components(separatedBy: "NutritionInformation\",").last
        let nutritionSection1 = nutritionSection0?.components(separatedBy: "}").first
        let nutritionSection2 = nutritionSection1?.components(separatedBy: ",") ?? [String]()
        
        for nutritionBlock in nutritionSection2 {
            print(nutritionBlock)
        }
    }
    
    
    // Retrieve recipe TITLE
    func parseRecipeTitle(htmlData: Data) {
        // parse html code here
        let htmlCode = String(data: htmlData, encoding: String.Encoding.utf8)
        //            print(htmlCode)
        
        let titleSection0 = htmlCode?.components(separatedBy: "og:title\" content=\"").last
        let title = titleSection0?.components(separatedBy: " | HelloFresh\"/><meta data-react-helmet").first
        
        print(title)
    }
    
    
    // Retrieve recipe DESCRIPTION
    func parseRecipeDescription(htmlData: Data) {
        // parse html code here
        let htmlCode = String(data: htmlData, encoding: String.Encoding.utf8)
        //            print(htmlCode)
        
        let descriptionSection0 = htmlCode?.components(separatedBy: "description\" content=\"").last
        let description = descriptionSection0?.components(separatedBy: "\"/><meta data-react-helmet").first
        
        print(description)
    }
    
    
    // Retrieve recipe THUMBNAIL
    func parseRecipeThumbnail(htmlData: Data) {
        // parse html code here
        let htmlCode = String(data: htmlData, encoding: String.Encoding.utf8)
        //            print(htmlCode)
        
        let thumbnailSection0 = htmlCode?.components(separatedBy: "\"true\" name=\"thumbnail\" content=\"").last
        let thumbnail = thumbnailSection0?.components(separatedBy: "\"/><meta data-react-helmet").first
        
        print(thumbnail)
    }
}
