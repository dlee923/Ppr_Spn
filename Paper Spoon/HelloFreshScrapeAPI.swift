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

class HelloFreshScrapeAPI: NSObject {
    
    func recipeLink() {
//        let urlString = "https://www.hellofresh.com/recipes/search/?order=-favorites"
        let urlString = "https://www.hellofresh.com/menus/"
//        let urlString = "https://www.hellofresh.com/recipes/italian-meatloaf-5d07d08ca79ba000160eed63"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print(err)
            }
            if let htmlData = data {
                self.parseMenuOptions(htmlData: htmlData)
            }
        }.resume()

    }
    
    func parseMenuOptions(htmlData: Data) {
        // create container to store menu options
        var menuOptions = [MenuOption]()
        
        // parse html code here
        let htmlCode = String(data: htmlData, encoding: String.Encoding.utf8)
        
//        print(htmlCode)
        
        guard let recipeLinks = htmlCode?.components(separatedBy: ",category") else { return }
        
        for recipeLink in recipeLinks {
            let link = recipeLink.components(separatedBy: ",label")
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
        
        for x in 0..<(menuOptions.count - 1) {
            print(menuOptions[x].recipeName)
            print(menuOptions[x].recipeLink)
            print()
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            print()
        }
    }
    
}
