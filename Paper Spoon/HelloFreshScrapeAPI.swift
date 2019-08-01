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
                guard let htmlCode = String(data: htmlData, encoding: String.Encoding.utf8) else { return }
                
//                self.parseMenuOptions(htmlCode: htmlCode)
                self.parseMenuIngredients(htmlCode: htmlCode)
//                self.parseRecipeInstructions(htmlCode: htmlCode)
//                self.parseRecipeNutrition(htmlCode: htmlCode)
//                self.parseRecipeTitle(htmlCode: htmlCode)
//                self.parseRecipeDescription(htmlCode: htmlCode)
//                self.parseRecipeThumbnail(htmlCode: htmlCode)
//                self.parseRecipeInstructionsImage(htmlCode: htmlCode)
            }
        }.resume()
    }
    
    
    // Retrieve recipe MENU OPTIONS
    func parseMenuOptions(htmlCode: String) {
        // create container to store menu options
        var menuOptions = [MenuOption]()
        
        // parse html code here
        let recipeLinks = htmlCode.components(separatedBy: ",category")
        
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
        }
    }
    
    
    // Retrieve recipe INGREDIENTS
    func parseMenuIngredients(htmlCode: String) {
        // create container to store ingredients
        var ingredients = [(String, String)]()
        
        // parse html code here
        let ingredientSection0 = htmlCode.components(separatedBy: "recipeIngredient").last
        let ingredientSection1 = ingredientSection0?.components(separatedBy: "recipeYield").first
        let ingredientSection2 = ingredientSection1?.components(separatedBy: ":[").last
        var ingredientSection3 = ingredientSection2?.components(separatedBy: "]").first
        // remove '\' characters from ingredients
        ingredientSection3?.removeAll(where: { (character) -> Bool in
            character == "\""
        })
        // separate all ingredients via ','
        let ingredientList = ingredientSection3?.components(separatedBy: ",") ?? [String]()
        
        // separate measurement from ingredient name
        for ingredient in ingredientList {
            let ingredientDetails = ingredient.components(separatedBy: " ")
            let measure = Double(String((ingredientDetails.first)!)) ?? 0.0
            
            if measure * 2 > 0 {
                let unitMeasure = ingredientDetails[...1].joined(separator: " ")
                let ingredientName = ingredientDetails[2...].joined(separator: " ")
                let ingredientData = (ingredientName, unitMeasure)
                ingredients.append(ingredientData)
            } else {
                ingredients.append((ingredientDetails[0], ""))
            }
        }
        
        for x in ingredients {
            print(x)
        }
    }
    
    
    // Retrieve recipe INSTRUCTIONS
    func parseRecipeInstructions(htmlCode: String) {
        // create container to store instructions
        var instructions = [String]()
        
        // parse html code here
        let instructionsSection0 = htmlCode.components(separatedBy: "recipeInstructions").last
        
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
    
    
    // Retrieve recipe INSTRUCTIONS IMAGE LINKS
    func parseRecipeInstructionsImage(htmlCode: String) {
        // create container to store instructions
        var instructionImgLinks = [String]()
        
        // parse html code here
        let instructionsImgSection0 = htmlCode.components(separatedBy: "recipeDetailFragment.instructions.step-image") ?? [String]()
        
        for x in 1..<(instructionsImgSection0.count - 1) {
            let instructionsImgLink1 = instructionsImgSection0[x].components(separatedBy: "img src=\"").last
            let instructionsImgLink = instructionsImgLink1?.components(separatedBy: "\" alt=").first ?? ""
            instructionImgLinks.append(instructionsImgLink)
        }
        
        for instructionImgLink in instructionImgLinks {
            print(instructionImgLink)
        }
    }
    
    
    // Retrieve recipe NUTRITION
    func parseRecipeNutrition(htmlCode: String) {
        // create container to store nutrition
        var nutrition = [String]()
        
        // parse html code here
        let nutritionSection0 = htmlCode.components(separatedBy: "NutritionInformation\",").last
        let nutritionSection1 = nutritionSection0?.components(separatedBy: "}").first
        let nutritionSection2 = nutritionSection1?.components(separatedBy: ",") ?? [String]()
        
        for nutritionBlock in nutritionSection2 {
            print(nutritionBlock)
        }
    }
    
    
    // Retrieve recipe TITLE
    func parseRecipeTitle(htmlCode: String) {
        // parse html code here
        let titleSection0 = htmlCode.components(separatedBy: "og:title\" content=\"").last
        let title = titleSection0?.components(separatedBy: " | HelloFresh\"/><meta data-react-helmet").first
        
        print(title)
    }
    
    
    // Retrieve recipe DESCRIPTION
    func parseRecipeDescription(htmlCode: String) {
        // parse html code here
        let descriptionSection0 = htmlCode.components(separatedBy: "description\" content=\"").last
        let description = descriptionSection0?.components(separatedBy: "\"/><meta data-react-helmet").first
        
        print(description)
    }
    
    
    // Retrieve recipe THUMBNAIL IMG LINK
    func parseRecipeThumbnail(htmlCode: String) {
        // parse html code here
        let thumbnailSection0 = htmlCode.components(separatedBy: "\"true\" name=\"thumbnail\" content=\"").last
        let thumbnailLink = thumbnailSection0?.components(separatedBy: "\"/><meta data-react-helmet").first
        
        print(thumbnailLink)
    }
}
