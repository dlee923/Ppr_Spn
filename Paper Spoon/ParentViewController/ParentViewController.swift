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
    
    // MARK:  UI Elements
    var splashImageView: SplashImageView?
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
//        self.tabBar.unselectedItemTintColor = UIColor.color6
        self.tabBar.barTintColor = UIColor.themeColor1
//        self.tabBar.backgroundImage = UIImage()
//        self.tabBar.shadowImage = UIImage()
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
    
    private func addGradientBackground() {
        let colorBottom = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1.0)
        let background = GradientView(frame: self.view.frame, colorTop: UIColor.clear.cgColor, colorBottom: colorBottom.cgColor)
        self.view.insertSubview(background, at: 0)
        background.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: self.view.topAnchor),
            background.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
        
    }
    
    private func addSplashImageView() {
        // control depth of splash image
        let splashRange: CGFloat = 0.3
        
        self.splashImageView = SplashImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: (self.view.bounds.height) * splashRange + 10))
        guard let splashImageView = self.splashImageView else { return }
        self.view.insertSubview(splashImageView, at: 0)
        splashImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            splashImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            splashImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            splashImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: splashRange),
            splashImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
    }

}

protocol ParentViewControllerDelegate: AnyObject {
    func changeViewController(index position: Int)
    func sendReducedCompiledIngredients(reducedCompiledIngredients: [Ingredients], completion: (() -> Void))
    func reloadCompiledIngredients()
    func reloadMealPrep()
    func reloadMealKitSelection()
    func fadeTabBar(fadeOut: Bool, fadePct: CGFloat)
    func fadeOutSplashImg(fadePct: CGFloat)
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
    
    func fadeTabBar(fadeOut: Bool, fadePct: CGFloat) {
        // return if already faded out
        if fadeOut == true && (self.tabBar.alpha) <= 0.0 { return }
        if fadeOut != true && (self.tabBar.alpha) >= 1.0 { return }
        
        // calculate alpha
        self.tabBar.alpha = fadePct
        
        if fadeOut {
            print("animate fade out")
        } else if !fadeOut {
            print("animate fade in")
        }
        
    }
    
    func fadeOutSplashImg(fadePct: CGFloat) {
        // return if already faded out
        if fadePct <= 0 || fadePct >= 1 { return }
        
        self.splashImageView?.alpha = fadePct
    }
}
