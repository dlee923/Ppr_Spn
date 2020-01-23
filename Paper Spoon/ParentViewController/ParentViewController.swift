//
//  ParentViewController.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 10/12/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class ParentViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.themeColor1
        self.addGradientBackground()
        self.addSplashImageView()
        
        // send delegate to viewControllers
        self.setupViewControllers()
        
        // set viewcontrollers
        self.addViewControllers()
        
        // set tabbar images
        self.setTabBarItems()
        
        // set properties
        self.setTabBarProperties()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // set initial item to be selected
        let brandsCollectionView = self.brandDashboardController.recipeListHeader.brandsPickerView
        brandsCollectionView.collectionView(brandsCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
    }
    
    // MARK:  Variables
    var menuOptionsObj = MenuOptionObj(menuOptions: nil)
    var fadeOut: Bool?
    
    // MARK:  UI Elements
    var splashImageView: SplashImageView?
    let brandDashboardController = BrandDashboardController()
    let compiledIngredientsViewController = CompiledIngredientsViewController()
    let mealPrepViewController = MealPrepViewController()
    let mealKitSelectionViewController = MealKitSelectionViewController()
    let favoritesViewController = UIViewController()
    
    private func addViewControllers() {
        self.viewControllers = [
            self.brandDashboardController,
            self.compiledIngredientsViewController,
            self.mealPrepViewController,
            self.mealKitSelectionViewController,
            self.favoritesViewController
        ]
    }
    
    private func setTabBarItems() {
        self.tabBar.items?[0].image = UIImage(named: "card2_75")
        self.tabBar.items?[0].title = "Recipes"
        self.tabBar.items?[1].image = UIImage(named: "cart2_75")
        self.tabBar.items?[1].title = "Ingredients"
        self.tabBar.items?[2].image = UIImage(named: "box2_75")
        self.tabBar.items?[2].title = "Assemble"
        self.tabBar.items?[3].image = UIImage(named: "cookbook2_75")
        self.tabBar.items?[3].title = "Meals"
        self.tabBar.items?[4].image = UIImage(named: "heart2_75")
        self.tabBar.items?[4].title = "Favorites"
    }
    
    private func setTabBarProperties() {
        // set tabbar color properties
        self.tabBar.tintColor = UIColor.themeColor4
        self.tabBar.barTintColor = UIColor.themeColor1

        // Remove tab bar line
        self.tabBar.layer.borderWidth = 0.0
        self.tabBar.clipsToBounds = true
    }
    
    private func setupViewControllers() {
        self.brandDashboardController.parentViewControllerDelegate = self
        self.brandDashboardController.menuOptionsObj = self.menuOptionsObj
        
        self.compiledIngredientsViewController.parentViewControllerDelegate = self
        self.compiledIngredientsViewController.menuOptionsObj = self.menuOptionsObj
        
        self.mealPrepViewController.parentViewControllerDelegate = self
        self.mealPrepViewController.menuOptionsObj = self.menuOptionsObj
        
        self.mealKitSelectionViewController.parentViewControllerDelegate = self
        self.mealKitSelectionViewController.menuOptionsObj = self.menuOptionsObj
    }

}

