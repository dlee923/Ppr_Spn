//
//  HelloFreshScrape.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 11/11/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import Foundation

class HelloFreshScrapeAPI: NSObject {
    
    static func recipeLink() {
        let urlString = "https://www.hellofresh.com/recipes/search/?order=-favorites"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print(err)
            }
            if let webData = data {
                let htmlCode = String(data: webData, encoding: String.Encoding.utf8)

                guard let recipeLinks = htmlCode?.components(separatedBy: ",author:null,name:\"") else { return }
                for recipeLink in recipeLinks {
                    let link = recipeLink.components(separatedBy: ",label")
                    if link.count > 1 {
//                        print(link)
                        let recipe = link.first
                        let recipeName = recipe?.components(separatedBy: ",slug:").first
                        let recipeLink = recipe?.components(separatedBy: "websiteUrl:\"").last
                        
                        print(recipeName)
                        print(recipeLink)
                        
                        if let ingredients = recipe?.components(separatedBy: "priority:") {
                            for ingredientContents in ingredients {
                                let ingredient = ingredientContents.components(separatedBy: "\",name:")
                                print(ingredient)
                            }
                        }
                        
                        print()
                    }
                }
            }
        }.resume()

    }
    
//    static func recipeLink() {
//        guard let urlString = URL(string: "https://www.hellofresh.com/recipes/search/?order=-favorites") else { return }
//        let htmlContents = try? String(contentsOf: urlString)
//        print(htmlContents)
//
//    }
}
