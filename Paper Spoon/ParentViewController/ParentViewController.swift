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
    let splashImageView = SplashImageView()
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
        self.tabBar.unselectedItemTintColor = UIColor.color6
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
        let colorBottom = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1.0)
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
    func minimizeBrandsCollectionView(isHidden: Bool)
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
    
    func minimizeBrandsCollectionView(isHidden: Bool) {
//         ignore function if tabbar is already set to the preferred status
//        if self.tabBar.isHidden == isHidden { return }
//        let offset = isHidden ? self.tabBar.frame.height : -self.tabBar.frame.height
//        print(offset)
//        
//        // pass height to each brandDashboardController
//        for brandViewController in self.brandDashboardController.controllers {
//            // access menuexpanded constant here:
//            if let brandViewControllr = brandViewController as? BrandViewController {
////                print(expandedValue)
////                brandViewControllr.menuOptionListExpandedConstant = offset
////                brandViewControllr.menuOptionListCollapsed?.isActive = false
////                brandViewControllr.menuOptionListExpanded?.isActive = true
//            }
//        }
//        
//        if isHidden {
//            self.tabBar.frame = self.tabBar.frame.offsetBy(dx: 0, dy: offset)
//            self.tabBar.isHidden = true
//            self.view.layoutIfNeeded()
//        } else {
//            self.tabBar.isHidden = false
//            self.tabBar.frame = self.tabBar.frame.offsetBy(dx: 0, dy: offset)
//            self.view.layoutIfNeeded()
//        }
    }
}
