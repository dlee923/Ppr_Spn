//
//  HelloFreshScrape.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 11/11/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import Foundation

// MARK:  HTML Calls
class HelloFreshAPI: BrandAPI {
    
    static let shared = HelloFreshAPI()
    
    override func retrieveMenuOptions(completion: ((Any) -> ())? ) {
        let urlString = "https://www.hellofresh.com/menus/"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print(err)
            }
            if let htmlData = data {
                guard let htmlCode = String(data: htmlData, encoding: String.Encoding.utf8) else { return }
                let menuOptions = self.parseMenuOptions(htmlCode: htmlCode)
                completion?(menuOptions)
            }
        }.resume()
    }
    
    override func retrieveRecipeInfo(urlString: String, completion: @escaping ((Recipe) -> ()) ) {
        guard let url = URL(string: urlString) else { return }
        print(url)

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print(err)
            }
            if let htmlData = data {
                guard let htmlCode = String(data: htmlData, encoding: String.Encoding.utf8) else { return }
                
                // parse recipe for recipe details
                var ingredients = self.parseMenuIngredients(htmlCode: htmlCode)
                let instructions = self.parseRecipeInstructions(htmlCode: htmlCode)
                let instructionImgs = self.parseRecipeInstructionsImage(htmlCode: htmlCode)
                let nutrition = self.parseRecipeNutrition(htmlCode: htmlCode)
                let title = self.parseRecipeTitle(htmlCode: htmlCode)
                let description = self.parseRecipeDescription(htmlCode: htmlCode)
                let thumbnailLink = self.parseRecipeThumbnail(htmlCode: htmlCode)
                let recipeImageLink = self.parseImageLinks(htmlCode: htmlCode)
                let ingredientImageLinks = self.parseIngredientImgLinks(htmlCode: htmlCode)
                
                // assign ingredient image links to each ingredient
                for x in 0..<ingredients.count {
                    ingredients[x].imageLink = ingredientImageLinks?[ingredients[x].name]
                }
                
                // create recipe object
                let recipe = Recipe(name: title, recipeLink: nil, ingredients: ingredients, instructions: instructions, instructionImageLinks: instructionImgs, ingredientImageLinks: ingredientImageLinks, recipeImageLink: recipeImageLink, thumbnailLink: thumbnailLink, nutrition: nutrition, description: description)
                
                completion(recipe)
            }
        }.resume()
    }

}


// MARK:  All parsing of html functions
extension HelloFreshAPI {
    
    // Retrieve recipe MENU OPTIONS
    fileprivate func parseMenuOptions(htmlCode: String) -> [MenuOption] {
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
                let recipeNameSection1 = recipeNameSection0?.components(separatedBy: "name:\"")[1]
                let recipeName = recipeNameSection1?.components(separatedBy: "\",slug:").first ?? ""
                
                // parse recipe subtitle
                let recipeSubtitleSection0 = recipeInfo?.components(separatedBy: "headline:\"").last
                let recipeSubtitleSection1 = recipeSubtitleSection0?.components(separatedBy: "\",websiteUrl:").first
                let recipeSubtitle = recipeSubtitleSection1 ?? ""
                
                // parse recipe link
                let recipeLink0 = recipeInfo?.components(separatedBy: "websiteUrl:\"").last
                let recipeLink = recipeLink0?.components(separatedBy: "\"").first ?? ""
                
                // create menu option
                let menuOption = MenuOption(recipeName: recipeName, recipeLink: recipeLink, recipe: nil, recipeSubtitle: recipeSubtitle, brandType: .HelloFresh)
                menuOptions.append(menuOption)
            }
        }
        
        return menuOptions
    }
    
    
    // Retrieve recipe INGREDIENTS
    private func parseMenuIngredients(htmlCode: String) -> [Ingredients] {
        // create container to store ingredients
        var ingredients = [Ingredients]()
        
        // parse html code here
        let ingredientSection0 = htmlCode.components(separatedBy: "recipeIngredient").last
        let ingredientSection1 = ingredientSection0?.components(separatedBy: "recipeYield").first
        let ingredientSection2 = ingredientSection1?.components(separatedBy: ":[").last
        var ingredientSection3 = ingredientSection2?.components(separatedBy: "]").first
        
        // remove '\' characters from ingredients
        ingredientSection3?.removeAll(where: { $0 == "\"" })
        
        // separate all ingredients via ','
        let ingredientList = ingredientSection3?.components(separatedBy: ",") ?? [String]()
        
        // separate measurement from ingredient name
        for ingredient in ingredientList {
            let ingredientDetails = ingredient.components(separatedBy: " ")
            
            if ingredientDetails.count > 1 {
                let ingredientAmount = Double(ingredientDetails.first ?? "0")
                let unitMeasure = ingredientDetails[1]
                let ingredientName = ingredientDetails[2...].joined(separator: " ")
                let ingredientData = Ingredients(name: ingredientName, amount: ingredientAmount, measurementType: unitMeasure, isPacked: nil, imageLink: nil, image: nil)
                ingredients.append(ingredientData)
            } else {
                let ingredientData = Ingredients(name: ingredientDetails[0], amount: nil, measurementType: nil, isPacked: nil, imageLink: nil, image: nil)
                ingredients.append(ingredientData)
            }
        }
        
        return ingredients
    }
    
    
    // Retrieve recipe INSTRUCTIONS
    private func parseRecipeInstructions(htmlCode: String) -> [String] {
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
        
        return instructions
    }
    
    
    // Retrieve recipe INSTRUCTIONS IMAGE LINKS
    private func parseRecipeInstructionsImage(htmlCode: String) -> [String] {
        // create container to store instructions
        var instructionImgLinks = [String]()
        
        // parse html code here
        let instructionsImgSection0 = htmlCode.components(separatedBy: "recipeDetailFragment.instructions.step-image")
        
        for x in 0..<(instructionsImgSection0.count - 1) {
            let instructionsImgLink1 = instructionsImgSection0[x].components(separatedBy: "img src=\"").last
            let instructionsImgLink = instructionsImgLink1?.components(separatedBy: "\" alt=").first ?? ""
            instructionImgLinks.append(instructionsImgLink)
        }
        
        return instructionImgLinks
    }
    
    
    // Retrieve recipe NUTRITION
    private func parseRecipeNutrition(htmlCode: String) -> Nutrition {
        // create temp container to store nutrition values for creating Nutrition object
        var nutritionValues = [String: NutritionValue]()
        
        // parse html code here
        let nutritionSection0 = htmlCode.components(separatedBy: "NutritionInformation\",").last
        var nutritionSection1 = nutritionSection0?.components(separatedBy: "}").first
        nutritionSection1?.removeAll(where: { $0 == "\"" })
        let nutritionSection2 = nutritionSection1?.components(separatedBy: ",") ?? [String]()
        
        for nutritionBlock in nutritionSection2 {
            let nutritionDetails = nutritionBlock.components(separatedBy: ":")
            let nutritionData = nutritionDetails.last?.components(separatedBy: " ")
            
            let nutritionAmount = Double(String(nutritionData?.first ?? "")) ?? 0.0
            let nutritionType = nutritionData?.last ?? ""
            let nutritionValue = NutritionValue(amount: nutritionAmount, measurementType: nutritionType)
            if let nutritionName = nutritionDetails.first {
                nutritionValues[nutritionName] = nutritionValue
            }
        }
        
        let nutrition = Nutrition(calories: nutritionValues["calories"],
                                  fatContent: nutritionValues["fatContent"],
                                  saturatedFatContent: nutritionValues["saturatedFatContent"],
                                  carbohydrateContent: nutritionValues["carbohydrateContent"],
                                  sugarContent: nutritionValues["sugarContent"],
                                  proteinContent: nutritionValues["proteinContent"],
                                  fiberContent: nutritionValues["fiberContent"],
                                  cholesterolContent: nutritionValues["cholesterolContent"],
                                  sodiumContent: nutritionValues["sodiumContent"])
        
        return nutrition
    }
    
    
    // Retrieve recipe TITLE
    private func parseRecipeTitle(htmlCode: String) -> String {
        // parse html code here
        let titleSection0 = htmlCode.components(separatedBy: "og:title\" content=\"").last
        let title = titleSection0?.components(separatedBy: " | HelloFresh\"/><meta data-react-helmet").first
        
        return title ?? ""
    }
    
    
    // Retrieve recipe DESCRIPTION
    private func parseRecipeDescription(htmlCode: String) -> String {
        // parse html code here
        let descriptionSection0 = htmlCode.components(separatedBy: "\"descriptionMarkdown\":").last
        let description = descriptionSection0?.components(separatedBy: ",\"author\"").first
        
        return description ?? ""
    }
    
    
    // Retrieve recipe THUMBNAIL IMG LINK
    private func parseRecipeThumbnail(htmlCode: String) -> String {
        // parse html code here
        let thumbnailSection0 = htmlCode.components(separatedBy: "\"true\" name=\"thumbnail\" content=\"").last
        let thumbnailLink = thumbnailSection0?.components(separatedBy: "\"/><meta data-react-helmet").first
        
        return thumbnailLink ?? ""
    }
    
    
    // Retrieve recipe RECIPE IMG LINKS
    private func parseImageLinks(htmlCode: String) -> String? {
        var imageLinks = [String:String]()
        
        // parse html code here
        let imagesSection0 = htmlCode.components(separatedBy: "fela-_1b1idjb\" src=\"").last
        let imagesSection1 = imagesSection0?.components(separatedBy: "srcSet=\\").last
        let imagesSection2 = imagesSection1?.components(separatedBy: "\" sizes=").first
        guard let imagesSection3 = imagesSection2?.components(separatedBy: ", ") else { return nil }
        for imagesSection4 in imagesSection3 {
            // parse each image set
            let imagesSection5 = imagesSection4.components(separatedBy: " ")
            // parse image size and image link
            let imageType: String = imagesSection5.last ?? ""
            var imageLink0: String = imagesSection5.first ?? ""
            imageLink0.removeAll(where: { $0 == "\"" })
            // add parsed strings to dict
            imageLinks[imageType] = imageLink0
        }
        
        /*
         OPTIONS
         ----------
         320w   1024w
         380w   1260w
         420w   1900w
         800w   2600w
        */
        
        return imageLinks["800w"]
    }
    
    
    // Retrieve recipe INGREDIENT IMG LINKS
    private func parseIngredientImgLinks(htmlCode: String) -> [String:String]? {
        var ingImageLinks = [String:String]()
        
        let baseUrl = "https://img.hellofresh.com/f_auto,fl_lossy,h_70,q_auto,w_70/hellofresh_s3"
//        let baseUrlFull = "https://img.hellofresh.com/hellofresh_s3" // ONLY USE THIS IF NEED FULL SIZE
        
        // parse html code here
        let ingImagesSection2 = htmlCode.components(separatedBy: "imagePath\":\"")
        for section in 2..<ingImagesSection2.count - 1 {
            // parse for ingredient name
            let imagesSection3 = ingImagesSection2[section].components(separatedBy: "name\":\"").last
            let ingredientName = imagesSection3?.components(separatedBy: "\",\"slug").first
            // parse for image link
            if let ingImageLink = ingImagesSection2[section].components(separatedBy: "\",\"usage").first {
                // add parsed strings to dict
                ingImageLinks[ingredientName!] = baseUrl + ingImageLink
            }
            
        }
        
        return ingImageLinks
    }
    
}
