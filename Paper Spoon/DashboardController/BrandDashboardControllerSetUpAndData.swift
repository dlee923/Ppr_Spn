//
//  BrandDashboardControllerSetUpAndData.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 1/11/20.
//  Copyright © 2020 DLEE. All rights reserved.
//

import UIKit

extension BrandDashboardController {
    
    internal func setUp() {
        passDelegates()
        passBrand()
        passMenuOptionsObj()
        passMenuBtnHeight()
        
        controllers = [helloFreshViewController, blueApronViewController, platedViewController, homeChefViewController]
        
        if let recipeListVC1 = controllers.first {
            self.setViewControllers([recipeListVC1], direction: .forward, animated: false, completion: nil)
        }
    }
    
    internal func passDelegates() {
        helloFreshViewController.brandDashboardControllerDelegate = self
        helloFreshViewController.parentViewControllerDelegate = self.parentViewControllerDelegate
        
        blueApronViewController.brandDashboardControllerDelegate = self
        blueApronViewController.parentViewControllerDelegate = self.parentViewControllerDelegate
        
        platedViewController.brandDashboardControllerDelegate = self
        platedViewController.parentViewControllerDelegate = self.parentViewControllerDelegate
        
        homeChefViewController.brandDashboardControllerDelegate = self
        homeChefViewController.parentViewControllerDelegate = self.parentViewControllerDelegate
    }
    
    internal func passBrand() {
        helloFreshViewController.brandView = .HelloFresh
        helloFreshViewController.brand = self.brands?.first(where: { $0.name == .HelloFresh })
        
        blueApronViewController.brandView = .BlueApron
        blueApronViewController.brand = self.brands?.first(where: { $0.name == .BlueApron })
        
        platedViewController.brandView = .BlueApron
        platedViewController.brand = self.brands?.first(where: { $0.name == .BlueApron })
        
        homeChefViewController.brandView = .HomeChef
        homeChefViewController.brand = self.brands?.first(where: { $0.name == .HomeChef })
    }
    
    internal func passMenuOptionsObj() {
        helloFreshViewController.menuOptionsObj = self.menuOptionsObj
        blueApronViewController.menuOptionsObj = self.menuOptionsObj
        platedViewController.menuOptionsObj = self.menuOptionsObj
        homeChefViewController.menuOptionsObj = self.menuOptionsObj
    }
    
    internal func passMenuBtnHeight() {
        if let compileIngredientsBtnHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height {
            let buttonHeight = self.compileIngredientsBtnHeight * CGFloat(compileIngredientsBtnHeight) + 5
            
            helloFreshViewController.menuOptionListExpandedConstant = buttonHeight
            blueApronViewController.menuOptionListExpandedConstant = buttonHeight
            platedViewController.menuOptionListExpandedConstant = buttonHeight
            homeChefViewController.menuOptionListExpandedConstant = buttonHeight
        }
    }
    
    internal func retrieveBrandMenu(brand: BrandType) {
        var brandAPI: BrandAPI?
        
        switch brand {
        case .HelloFresh : brandAPI = HelloFreshAPI.shared
        case .BlueApron  : brandAPI = BlueApronAPI.shared
        case .HomeChef   :  brandAPI = HomeChefAPI.shared
        default: return
        }
        
        let retrieveMenuOptions = DispatchWorkItem {
            brandAPI?.retrieveMenuOptions(completion: { (data) in
                if let menuOptions = data as? [MenuOption] {
                    self.menuOptionsObj?.menuOptions[brand] = menuOptions
                    self.dispatchGroup.leave()
                }
            })
        }
        self.dispatchGroup.enter()
        
        backgroundThread.async(group: dispatchGroup, execute: retrieveMenuOptions)
        self.dispatchGroup.wait()
    }
    
    
    internal func retrieveRecipeData(brand: BrandType) {
        guard let menuOptions = self.menuOptionsObj?.menuOptions[brand] else { return }
        var menuOptionsCount = 0
        var brandAPI: BrandAPI?
        
        switch brand {
        case .HelloFresh : brandAPI = HelloFreshAPI.shared
        case .BlueApron  : brandAPI = BlueApronAPI.shared
        case .HomeChef   : brandAPI = HomeChefAPI.shared
        default: return
        }
        
        // download recipe details for each menu option
        for menuOption in menuOptions {
            let retrieveRecipeData = DispatchWorkItem {
                brandAPI?.retrieveRecipeInfo(urlString: menuOption.recipeLink, completion: { (recipe) in
                    
                    // find index for recipe in menu options and attach recipe object
                    if let menuIndex = self.menuOptionsObj?.menuOptions[brand]?.firstIndex(where: { $0.recipeLink == menuOption.recipeLink }) {
                        self.menuOptionsObj?.menuOptions[brand]?[menuIndex].recipe = recipe
                        
                        // increment count through menu options
                        menuOptionsCount += 1
                        print("\(menuOptionsCount) / \(menuOptions.count)")
                        
                        // trigger leave group if final completion
                        if menuOptionsCount >= menuOptions.count {
                            self.dispatchGroup.leave()
                        }
                    }
                })
            }
            self.backgroundThread.async(group: dispatchGroup, execute: retrieveRecipeData)
        }
        self.dispatchGroup.enter()
        self.dispatchGroup.wait()
    }
    
    
    internal func retrieveThumbnail(brand: BrandType) {
        guard let menuOptions = self.menuOptionsObj?.menuOptions[brand] else { return }
        
        // download thumbnail for each menu option
        for menuOption in menuOptions {
            let retrieveThumbnail = DispatchWorkItem {
                
                if let thumbnailLink = menuOption.recipe?.thumbnailLink {
                    ImageAPI.shared.downloadImage(urlLink: thumbnailLink, completion: { (thumbnailData) in
                        if let menuIndex = self.menuOptionsObj?.menuOptions[brand]?.firstIndex(where: { $0.recipeLink == menuOption.recipeLink }) {
                            self.menuOptionsObj?.menuOptions[brand]?[menuIndex].recipe?.thumbnail = UIImage(data: thumbnailData)

                            self.dispatchGroup.leave()
                        }
                    })
                }
                
            }
            self.dispatchGroup.enter()
            backgroundThread.async(group: dispatchGroup, execute: retrieveThumbnail)
        }
    }
    
    internal func createBrands() {
        let helloFresh = Brand(name:        .HelloFresh,
                               image:       UIImage(named: "hellofresh_x1.png")!,
                               largeImage:  UIImage(named: "hellofresh_x2.png")!)
        
        let blueApron =  Brand(name:        .BlueApron,
                               image:       UIImage(named: "blueapron_x1.png")!,
                               largeImage:  UIImage(named: "blueapron_x2.png")!)
        
        let everyPlate = Brand(name:        .EveryPlate,
                               image:       UIImage(named: "plated_x1.png")!,
                               largeImage:  UIImage(named: "hellofresh_x2.png")!)
        
        let homeChef =   Brand(name:        .HomeChef,
                               image:       UIImage(named: "homechef_x1.png")!,
                               largeImage:  UIImage(named: "homechef_x2.png")!)
        
//        let plated = Brand(name: .Plated, image: UIImage(named: "plated_x1.png")!)
//        let purpleCarrot = Brand(name: .PurpleCarrot, image: UIImage(named: "plated_x1.png")!)
        
        self.brands = [
            helloFresh,
            blueApron,
            everyPlate,
            homeChef
        ]
    }
    
    internal func calculateIngredients(completion: () -> ()) {
        // aggregate all ingredients from selected recipes
        guard let selectedMenuOptions = self.menuOptionsObj?.selectedMenuOptions else { return }
        
        // reset compiledIngredients
        self.compiledIngredients.removeAll()
        
        for menuOption in selectedMenuOptions {
            if let recipeIngredients = menuOption.recipe?.ingredients {
                self.compiledIngredients += recipeIngredients
            }
        }
        
        // standardize ingredient measurements
        
        // standardize ingredient names
        
        
        
        // reduce ingredients list to just unique values based on name only
        reducedCompiledIngredients = compiledIngredients.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
        for ingredient in reducedCompiledIngredients {
            print(ingredient.name)
        }
        
        // modify ingredients list amounts based on original compiledIngredients list
        
        completion()
    }
    
    internal func downloadIngredientImages() {
        self.mainThread.async {
            self.activityIndicator.activityInProgress()
        }
        
        self.dispatchGroup.enter()
        
        for x in 0..<self.reducedCompiledIngredients.count {
            let dispatchWorkItem = DispatchWorkItem(block: {
                
                if let imageLink = self.reducedCompiledIngredients[x].imageLink {
                    print(imageLink)
                    ImageAPI.shared.downloadImage(urlLink: imageLink, completion: {
                        self.reducedCompiledIngredients[x].image = UIImage(data: $0)
                        self.workItemCompletionCount += 1
                        
                        if self.workItemCompletionCount >= self.workItemCompletionLimit {
                            print("\(self.workItemCompletionCount) / \(self.workItemCompletionLimit)")
                            print("done")
                            self.dispatchGroup.leave()
                        }
                    })
                }
            })
            self.backgroundThread.async(group: self.dispatchGroup, execute: dispatchWorkItem)
        }
    }
    
    
    internal func allocateIngredientImages() {
        guard let selectedMenuOptions = self.menuOptionsObj?.selectedMenuOptions else { return }
        
        for menuOption in selectedMenuOptions {
            if let ingredients = menuOption.recipe?.ingredients {
                for ingredient in ingredients {
                    let ingredientImg = self.reducedCompiledIngredients.first(where: { $0.name == ingredient.name })
                    ingredient.image = ingredientImg?.image
                }
            }
        }
    }
    
    
    internal func downloadRecipeImages() {
        guard let selectedMenuOptions = self.menuOptionsObj?.selectedMenuOptions else { return }
        
        for menuOption in selectedMenuOptions {
            let dispatchWorkItem = DispatchWorkItem {
                if let imageURL = menuOption.recipe?.recipeImageLink {
                    ImageAPI.shared.downloadImage(urlLink: imageURL, completion: {
                        menuOption.recipe?.recipeImage = UIImage(data: $0)
                        self.workItemCompletionCount += 1
                        
                        if self.workItemCompletionCount >= self.workItemCompletionLimit {
                            print("\(self.workItemCompletionCount) / \(self.workItemCompletionLimit)")
                            print("done")
                            self.dispatchGroup.leave()
                        }
                        
                    })
                }
            }
            self.backgroundThread.async(group: self.dispatchGroup, execute: dispatchWorkItem)
        }
    }
}
