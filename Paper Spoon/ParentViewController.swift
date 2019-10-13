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

        // set viewcontrollers
        self.viewControllers = [
            self.brandDashboardController,
            self.compileIngredientsViewController,
            self.mealPrepViewController,
            self.mealKitSelectionViewController
        ]
        
        // set tabbar images
        self.setTabBarItems()
        
        // set properties
        self.setTabBarProperties()
        
        // send delegate to viewControllers
        self.sendDelegates()
        
    }
    
    let brandDashboardController = BrandDashboardController()
    let compileIngredientsViewController = UIViewController()
    let mealPrepViewController = UIViewController()
    let mealKitSelectionViewController = UIViewController()
    
    private func setTabBarItems() {
        self.tabBar.items?[0].image = UIImage(named: "list_75")
        self.tabBar.items?[0].title = "Select Recipes"
        self.tabBar.items?[1].image = UIImage(named: "cart_75")
        self.tabBar.items?[1].title = "Ingredient List"
        self.tabBar.items?[2].image = UIImage(named: "box_75")
        self.tabBar.items?[2].title = "Assemble Meals"
        self.tabBar.items?[3].image = UIImage(named: "chef_75")
        self.tabBar.items?[3].title = "Prepped Meals"
    }
    
    private func setTabBarProperties() {
        // set tabbar color properties
        self.tabBar.tintColor = UIColor.themeColor2
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = UIColor.themeColor1
        // Remove tab bar line
        self.tabBar.layer.borderWidth = 0.0
        self.tabBar.clipsToBounds = true
    }
    
    private func sendDelegates() {
        self.brandDashboardController.parentViewControllerDelegate = self
//        self.compileIngredientsViewController.delegate = self
//        self.mealPrepViewController.delegate = self
//        self.mealKitSelectionViewController.delegate = self
    }

}

protocol ParentViewControllerDelegate: AnyObject {
    func changeViewController(index position: Int)
}

extension ParentViewController: ParentViewControllerDelegate {
    func changeViewController(index position: Int) {
        self.selectedIndex = position
    }
}
