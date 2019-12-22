//
//  BlueApronAPI.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 12/15/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

extension String {
    
    func convertHtml() -> NSAttributedString{
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        
        if let attributedString = try? NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            attributedString.addAttribute(.font, value: UIFont.fontCoolvetica?.withSize(15), range: NSMakeRange(0, self.count))
            return attributedString
        } else {
            return NSAttributedString()
        }
    }
    
}

class BlueApronAPI: BrandAPI {

    static let shared = BlueApronAPI()
    
    func retrieveMenuOptions(completion: ((Any) -> ())? ) {
        let urlString = "https://www.blueapron.com/pages/sample-recipes"
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
//                let recipeImageLink = self.parseImageLinks(htmlCode: htmlCode)
//                let ingredientImageLinks = self.parseIngredientImgLinks(htmlCode: htmlCode)
//                
//                // assign ingredient image links to each ingredient
//                for x in 0..<ingredients.count {
//                    ingredients[x].imageLink = ingredientImageLinks?[ingredients[x].name]
//                }
//                
                // create recipe object
                let recipe = Recipe(name: title, recipeLink: nil, ingredients: ingredients, instructions: instructions, instructionImageLinks: instructionImgs, ingredientImageLinks: nil, recipeImageLink: thumbnailLink, thumbnailLink: thumbnailLink, nutrition: nutrition, description: description)
                
                completion(recipe)
            }
        }.resume()
    }
}

extension BlueApronAPI {
    
    // Retrieve recipe MENU OPTIONS
        fileprivate func parseMenuOptions(htmlCode: String) -> [MenuOption] {
            // create container to store menu options
            var menuOptions = [MenuOption]()
            // parse html code here
            let weeklyRecipes = htmlCode.components(separatedBy: "Week of")[1]
            
            let recipeLinks = htmlCode.components(separatedBy: "class=\"recipe-card recipe-product-card\" href=\"")
            
            let maxRecipeCount = recipeLinks.count > 11 ? 11 : recipeLinks.count
            
            for x in 1..<(maxRecipeCount) {
                let link = recipeLinks[x].components(separatedBy: "\"><div class").first ?? ""
                let recipeLink = "https://www.blueapron.com" + link
    
                // parse recipe name
                let recipeNameSection0 = recipeLinks[x].components(separatedBy: "<div class='recipe-content__title'>").last
                let recipeNameSection1 = recipeNameSection0?.components(separatedBy: "</div>").first ?? ""
                let recipeName = recipeNameSection1.components(separatedBy: "amp; ").joined(separator: " ")

                // parse recipe subtitle
                let recipeSubtitleSection0 = recipeLinks[x].components(separatedBy: "<div class='recipe-content__subtitle'>").last
                let recipeSubtitleSection1 = recipeSubtitleSection0?.components(separatedBy: "</div>").first ?? ""
                let recipeSubtitle = recipeSubtitleSection1.components(separatedBy: "amp; ").joined(separator: " ")
                
                // create menu option
                let menuOption = MenuOption(recipeName: recipeName, recipeLink: recipeLink, recipe: nil, recipeSubtitle: recipeSubtitle, brandType: .BlueApron)
                menuOptions.append(menuOption)
            }
            
            return menuOptions
        }
        
        
        // Retrieve recipe INGREDIENTS
        private func parseMenuIngredients(htmlCode: String) -> [Ingredients] {
            print("new recipe!")
            // create container to store ingredients
            var ingredients = [Ingredients]()
            
            // parse html code here
            let ingredientList = htmlCode.components(separatedBy: "itemprop='recipeIngredient'")
            
            // separate measurement from ingredient name
            for x in 1..<ingredientList.count - 1 {
                let ingredientDetails = ingredientList[x].components(separatedBy: "<span>")
                
                let ingredientNameSection0 = ingredientDetails[1].components(separatedBy: "</span>\n").last
                let ingredientName = ingredientNameSection0?.components(separatedBy: "\n</div>").first ?? ""
                
                let ingredientAmountData = ingredientDetails[1].components(separatedBy: "\n")
                let ingredientAmount = Double(ingredientAmountData[1])
                let unitMeasure = ingredientAmountData.count > 1 ? ingredientAmountData[2] : nil
                
                let ingredientData = Ingredients(name: ingredientName, amount: ingredientAmount, measurementType: unitMeasure, isPacked: nil, imageLink: nil, image: nil)
                ingredients.append(ingredientData)
            }
            
//            for ingredient in ingredients {
//                print("\(ingredient.name), \(ingredient.amount), \(ingredient.measurementType)")
//            }
            
            return ingredients
        }
        
        
        // Retrieve recipe INSTRUCTIONS
        private func parseRecipeInstructions(htmlCode: String) -> [String] {
            // create container to store instructions
            var instructions = [String]()
            
            // parse html code here
            var instructionsSection0 = htmlCode.components(separatedBy: "<div class='step-txt'>\n<p>")
            instructionsSection0.removeFirst()
            
            for instructionBlock in instructionsSection0 {
                let instruction = instructionBlock.components(separatedBy: "</p>").first ?? ""
                instructions.append(instruction)
            }
            
            
            return instructions
        }
        
        
        // Retrieve recipe INSTRUCTIONS IMAGE LINKS
        private func parseRecipeInstructionsImage(htmlCode: String) -> [String] {
            // create container to store instructions
            var instructionImgLinks = [String]()
            
            // parse html code here
            let instructionsImgSection0 = htmlCode.components(separatedBy: "<div class='p-15' itemprop='recipeInstructions'>")
            
            for x in 0..<(instructionsImgSection0.count - 1) {
                let instructionsImgLink1 = instructionsImgSection0[x].components(separatedBy: "src=\"").last
                let instructionsImgLink = instructionsImgLink1?.components(separatedBy: "\" />").first ?? ""
                print(instructionsImgLink)
                instructionImgLinks.append(instructionsImgLink)
            }
            
            return instructionImgLinks
        }
        
        
        // Retrieve recipe NUTRITION
        private func parseRecipeNutrition(htmlCode: String) -> Nutrition {
            
            // parse html code here
            let nutritionSection0 = htmlCode.components(separatedBy: "<span itemprop='calories'>").last
            let calorieCount = Double(nutritionSection0?.components(separatedBy: "</span>").first ?? "0.0")
            let calorie = NutritionValue(amount: Double(calorieCount ?? 0.0), measurementType: "Calories")
            
            let nutrition = Nutrition(calories: calorie, fatContent: nil, saturatedFatContent: nil, carbohydrateContent: nil, sugarContent: nil, proteinContent: nil, fiberContent: nil, cholesterolContent: nil, sodiumContent: nil)
            
            return nutrition
        }
        
        
        // Retrieve recipe TITLE
        private func parseRecipeTitle(htmlCode: String) -> String {
            // parse html code here
            let titleSection0 = htmlCode.components(separatedBy: "<h1 class='ba-recipe-title__main'>\n").last
            let titleSection1 = titleSection0?.components(separatedBy: "\n</h1>").first
            let titleComponents = titleSection1?.components(separatedBy: "amp;")
            for x in titleComponents! {
                print(x)
            }
            let title = titleComponents?.joined(separator: " ")
            
            
            return title ?? ""
        }
        
        
        // Retrieve recipe DESCRIPTION
        private func parseRecipeDescription(htmlCode: String) -> String {
            // parse html code here
            let descriptionSection0 = htmlCode.components(separatedBy: "<p itemprop='description'>").last
            let description = descriptionSection0?.components(separatedBy: "</p>").first
            
            return description ?? ""
        }
    
        
        // Retrieve recipe THUMBNAIL IMG LINK
        private func parseRecipeThumbnail(htmlCode: String) -> String {
            // parse html code here
            let thumbnailSection0 = htmlCode.components(separatedBy: "<div class='ba-hero-image__hldr'>\n<img class=\"img-max\"").last
            let thumbnailSection1 = thumbnailSection0?.components(separatedBy: "src=\"")[1]
            let thumbnailLink = thumbnailSection1?.components(separatedBy: "\" />").first
            
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


