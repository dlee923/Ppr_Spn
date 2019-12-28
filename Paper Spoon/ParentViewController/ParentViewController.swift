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
        self.addGradientBackground()
        
        // send delegate to viewControllers
        self.setupViewControllers()
        
        // set viewcontrollers
        self.addViewControllers()
        
        // set tabbar images
        self.setTabBarItems()
        
        // set properties
        self.setTabBarProperties()
    }
    
    // MARK:  Variables
    var menuOptionsObj = MenuOptionObj(menuOptions: nil)
    
    // MARK:  UI Elements
    let brandDashboardController = BrandDashboardController()
    let compiledIngredientsViewController = CompiledIngredientsViewController()
    let mealPrepViewController = MealPrepViewController()
    let mealKitSelectionViewController = MealKitSelectionViewController()
    let savedMenuListViewController = UIViewController()
    
    private func addViewControllers() {
        self.viewControllers = [
            self.brandDashboardController,
            self.compiledIngredientsViewController,
            self.mealPrepViewController,
            self.mealKitSelectionViewController,
            self.savedMenuListViewController
        ]
    }
    
    private func setTabBarItems() {
        self.tabBar.items?[0].image = UIImage(named: "list_75")
        self.tabBar.items?[0].title = "Recipes"
        self.tabBar.items?[1].image = UIImage(named: "cart_75")
        self.tabBar.items?[1].title = "Ingredients"
        self.tabBar.items?[2].image = UIImage(named: "box_75")
        self.tabBar.items?[2].title = "Assemble"
        self.tabBar.items?[3].image = UIImage(named: "chef_75")
        self.tabBar.items?[3].title = "Meals"
        self.tabBar.items?[4].image = UIImage(named: "folder_75")
        self.tabBar.items?[4].title = "Saved Menus"
    }
    
    private func setTabBarProperties() {
        // set tabbar color properties
        self.tabBar.tintColor = UIColor.themeColor2
        self.tabBar.isTranslucent = true
        self.tabBar.barTintColor = UIColor.clear
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
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
    
    internal func addGradientBackground() {
        let colorBottom = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1.0)
        let background = GradientView(frame: self.view.frame, colorTop: UIColor.themeColor1.cgColor, colorBottom: colorBottom.cgColor)
        self.view.insertSubview(background, at: 0)
        background.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: self.view.topAnchor),
            background.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
        
    }

}

protocol ParentViewControllerDelegate: AnyObject {
    func changeViewController(index position: Int)
    func sendReducedCompiledIngredients(reducedCompiledIngredients: [Ingredients], completion: (() -> Void))
    func reloadCompiledIngredients()
    func reloadMealPrep()
    func reloadMealKitSelection()
}

extension ParentViewController: ParentViewControllerDelegate {
    func changeViewController(index position: Int) {
        self.selectedIndex = position
    }
    
    func sendReducedCompiledIngredients(reducedCompiledIngredients: [Ingredients], completion: (() -> Void)) {
        self.compiledIngredientsViewController.reducedCompiledIngredients = reducedCompiledIngredients
        self.reloadCompiledIngredients()
        self.reloadMealPrep()
        completion()
    }
    
    func reloadCompiledIngredients() {
        self.compiledIngredientsViewController.compiledIngredientsList.reloadData()
    }
    
    func reloadMealPrep() {
        self.mealPrepViewController.mealsPrepCollectionView.reloadData()
    }
    
    func reloadMealKitSelection() {
        self.mealKitSelectionViewController.mealKitsCollectionView.reloadData()
    }
}
