//
//  HomeChefAPI.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 12/22/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import Foundation

class HomeChefAPI: BrandAPI {
    
    static let shared = HomeChefAPI()
    
    override func retrieveMenuOptions(completion: ((Any) -> ())? ) {
        let urlString = "https://www.homechef.com/our-menu"
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
//                let ingredientImageLinks = self.parseIngredientImgLinks(htmlCode: htmlCode)

//                // assign ingredient image links to each ingredient
//                for x in 0..<ingredients.count {
//                    ingredients[x].imageLink = ingredientImageLinks?[ingredients[x].name]
//                }

                // create recipe object
                let recipe = Recipe(name: title,
                                    recipeLink: nil,
                                    ingredients: ingredients,
                                    instructions: instructions,
                                    instructionImageLinks: instructionImgs,
                                    ingredientImageLinks: nil,
                                    recipeImageLink: recipeImageLink,
                                    thumbnailLink: thumbnailLink,
                                    nutrition: nutrition,
                                    description: description)

                completion(recipe)
            }
        }.resume()
    }

}


// MARK:  All parsing of html functions
extension HomeChefAPI {
    
    // Retrieve recipe MENU OPTIONS
    fileprivate func parseMenuOptions(htmlCode: String) -> [MenuOption] {
        // create container to store menu options
        var menuOptions = [MenuOption]()
        
        // cut html range
        let htmlCodeLimit = htmlCode.components(separatedBy: "Protein Packs").first ?? ""
        
        // parse html code here
        let recipeLinks = htmlCodeLimit.components(separatedBy: "meal_title\" data-amplitude-value=\"")
        
        for x in 1..<(recipeLinks.count) {
                
            // parse recipe titles
            let recipeSubtitleSection0 = recipeLinks[x].components(separatedBy: "data-pin-description=\"").last
            let recipeSubtitleSection1 = recipeSubtitleSection0?.components(separatedBy: "\" data-pin-media").first ?? ""
            let recipeSubtitleSection2 = recipeSubtitleSection1.components(separatedBy: "&amp; ").joined()
            
            // parse recipe name
            let recipeName = recipeSubtitleSection2.components(separatedBy: " with").first ?? ""
            
            // parse subtitle
            var recipeSubtitleSection3 = recipeSubtitleSection2.components(separatedBy: "with ")
            recipeSubtitleSection3.removeFirst()
            let recipeSubtitle = "with " + recipeSubtitleSection3.joined(separator: "with ")
            
            // parse recipe link
            let recipeLinkSection0 = recipeLinks[x].components(separatedBy: "data-pin-url=\"").last
            let recipeLink = recipeLinkSection0?.components(separatedBy: "\" data-pin-description").first ?? ""
            
            // create menu option
            let menuOption = MenuOption(recipeName: recipeName, recipeLink: recipeLink, recipe: nil, recipeSubtitle: recipeSubtitle, brandType: .HelloFresh)
            menuOptions.append(menuOption)
        }
        
        return menuOptions
    }
    
    
    // Retrieve recipe INGREDIENTS
    private func parseMenuIngredients(htmlCode: String) -> [Ingredients] {
        // create container to store ingredients
        var ingredients = [Ingredients]()
        
        // parse html code here
        let ingredientSection0 = htmlCode.components(separatedBy: "download recipe</a>").last
        var ingredientList = ingredientSection0?.components(separatedBy: "itemprop='recipeIngredient'>\n") ?? [""]
        ingredientList.removeFirst()
        
        print(ingredientList.first)
        
        // separate measurement from ingredient name
        for ingredient in ingredientList {
            var ingredientDetails0: String?
            // if there exists a </div>\n
            if let ingredientDetails_ = ingredient.components(separatedBy: "</path>\n</svg>\n</div>\n").last {
                ingredientDetails0 = ingredientDetails_
            // if there does not exist a </div>\n
            } else {
                ingredientDetails0 = ingredient
            }
            let ingredientDetails1 = ingredientDetails0?.components(separatedBy: "\n</li>").first
            let ingredientDetails = ingredientDetails1?.components(separatedBy: "\n")
            
            let ingredientAmount = Double(ingredientDetails?.first ?? "0")
            let unitMeasure = ingredientDetails?[1] ?? ""
            let ingredientName = ingredientDetails?[2] ?? ""
            let ingredientName0 = ingredientName.replacingOccurrences(of: "amp;", with: "")
            
            print("\(ingredientAmount) \(unitMeasure) \(ingredientName0)")
            
            let ingredientData = Ingredients(name: ingredientName0,
                                             amount: ingredientAmount,
                                             measurementType: unitMeasure,
                                             isPacked: nil,
                                             imageLink: nil,
                                             image: nil)
            
            ingredients.append(ingredientData)
            
        }
        
        // remove where ingredient is <script>
        ingredients.removeAll(where: { $0.name == "<script>" })
        
        return ingredients
    }
    
    
    // Retrieve recipe INSTRUCTIONS
    private func parseRecipeInstructions(htmlCode: String) -> [String] {
        // create container to store instructions
        var instructions = [String]()
        
        // parse html code here
        var instructionsSection0 = htmlCode.components(separatedBy: "</figcaption>\n</figure>")
        instructionsSection0.removeFirst()
        
        for x in 1..<instructionsSection0.count {
            let instructionsSection = instructionsSection0[x].components(separatedBy: "itemprop='description'><p>").last
            let instruction = instructionsSection?.components(separatedBy: "</p>").first ?? ""
            let filteredInstruction = instruction.replacingOccurrences(of: "&#39;|<strong>|</strong>|<em>|</em>", with: "", options: .regularExpression, range: nil)
            let filteredInstruction0 = filteredInstruction.replacingOccurrences(of: "&frac12;&quot;", with: "1/2")
            instructions.append(filteredInstruction)
        }
        
        return instructions
    }
    
    
    // Retrieve recipe INSTRUCTIONS IMAGE LINKS
    private func parseRecipeInstructionsImage(htmlCode: String) -> [String] {
        // create container to store instructions
        var instructionImgLinks = [String]()
        
        // parse html code here
        let instructionsImgSection0 = htmlCode.components(separatedBy: "itemListElement")

        for x in 1..<(instructionsImgSection0.count) {
            let instructionsImgLink0 = instructionsImgSection0[x].components(separatedBy: "750w,\n").last
            let instructionsImgLink1 = instructionsImgLink0?.components(separatedBy: " 800w").first
            let instructionsImgLink2 = instructionsImgLink1?.replacingOccurrences(of: "&amp;", with: "&")
            let instructionsImgLink = instructionsImgLink2?.replacingOccurrences(of: " ", with: "") ?? ""
            instructionImgLinks.append(instructionsImgLink)
        }
        
        return instructionImgLinks
    }
    
    
    // Retrieve recipe NUTRITION
    private func parseRecipeNutrition(htmlCode: String) -> Nutrition {
        // create temp container to store nutrition values for creating Nutrition object
        var nutritionValues = [String: NutritionValue]()
        
        // parse html code here
        let nutritionSection0 = htmlCode.components(separatedBy: "meal__nutrition").last
        
        let nutritionTypes = [
            "calories"              :   "itemprop='calories'>",
            "carbohydrateContent"   :   "itemprop='carbohydrateContent'>",
            "fatContent"            :   "itemprop='fatContent'>",
            "proteinContent"        :   "itemprop='proteinContent'>",
            "sodiumContent"         :   "itemprop='sodiumContent'>"
        ]
        
        for (nutritionType, indicator) in nutritionTypes {
            let nutritionComponents0 = nutritionSection0?.components(separatedBy: indicator).last
            let nutritionComponents1 = nutritionComponents0?.components(separatedBy: "</strong>").first
            let nutritionComponents2 = nutritionComponents1?.components(separatedBy: CharacterSet.letters)
            let nutritionAmount = nutritionComponents2?.first ?? ""
            let measurementType = nutritionComponents2?[1...].joined() ?? ""
            let nutritionValue = NutritionValue(amount: Double(String(nutritionAmount)) ?? 0.0, measurementType: measurementType)
            nutritionValues[nutritionType] = nutritionValue
        }
        
        let nutrition = Nutrition(calories: nutritionValues["calories"],
                                  fatContent: nutritionValues["fatContent"],
                                  saturatedFatContent: nil,
                                  carbohydrateContent: nutritionValues["carbohydrateContent"],
                                  sugarContent: nil,
                                  proteinContent: nutritionValues["proteinContent"],
                                  fiberContent: nil,
                                  cholesterolContent: nil,
                                  sodiumContent: nutritionValues["sodiumContent"])
        
        return nutrition
    }
    
    
    // Retrieve recipe TITLE
    private func parseRecipeTitle(htmlCode: String) -> String {
        // parse html code here
        let titleSection0 = htmlCode.components(separatedBy: "id='mainContent'").last
        let titleSection1 = titleSection0?.components(separatedBy: "<h1 class='h--serif size--lg size--m--bpDown2 no--margin'>").last
        let title = titleSection0?.components(separatedBy: "</h1>").first
        
        return title ?? ""
    }
    
    
    // Retrieve recipe DESCRIPTION
    private func parseRecipeDescription(htmlCode: String) -> String {
        // parse html code here
        var descriptionSection0 = htmlCode.components(separatedBy: "</figcaption>\n</figure>")
        descriptionSection0.removeFirst()
        let descriptionsSection1 = descriptionSection0[0].components(separatedBy: "itemprop='description'>\n<p>").last
        let description = descriptionsSection1?.components(separatedBy: "</p>").first
        let filteredDescription = description?.replacingOccurrences(of: "&#39;|<strong>|</strong>|<em>|</em>", with: "'")
        
        return filteredDescription ?? ""
    }
    
    
    // Retrieve recipe THUMBNAIL IMG LINK
    private func parseRecipeThumbnail(htmlCode: String) -> String {
        // parse html code here
        let thumbnailSection0 = htmlCode.components(separatedBy: "meal__imageCarousel").last
        let thumbnailSection1 = thumbnailSection0?.components(separatedBy: "425w, ")[1]
        let thumbnailSection2 = thumbnailSection1?.components(separatedBy: " 850w").first
        let thumbnailLink = thumbnailSection2?.replacingOccurrences(of: "&amp;", with: "&")
        
        return thumbnailLink ?? ""
    }
    
    
    // Retrieve recipe RECIPE IMG LINKS
    private func parseImageLinks(htmlCode: String) -> String? {
        // parse html code here
        let imagesSection0 = htmlCode.components(separatedBy: "meal__imageCarousel").last
        let imagesSection1 = imagesSection0?.components(separatedBy: "850w, ")[1]
        let imagesSection2 = imagesSection1?.components(separatedBy: " 1700w").first
        let imageLink = imagesSection2?.replacingOccurrences(of: "&amp;", with: "&")
        
        return imageLink ?? ""
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
