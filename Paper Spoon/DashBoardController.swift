//
//  ViewController.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 11/11/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

class DashBoardController: UIPageViewController, UIPageViewControllerDataSource{
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewController.OptionsKey.spineLocation: UIPageViewController.SpineLocation.mid])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        self.setUp()
    }
    
    var recipeListViewController: RecipeListViewController = {
        let recipeListVC = RecipeListViewController()
        return recipeListVC
    }()
    
    var favoritesVC: UIViewController = {
        let favoritesVC = UIViewController()
        favoritesVC.view.backgroundColor = .green
        return favoritesVC
    }()
    
    var labVC: UIViewController = {
        let labVC = UIViewController()
        labVC.view.backgroundColor = .blue
        return labVC
    }()

    var controllers = [UIViewController]()
    
    let activityinidicator = ActivityIndicator()
    let helloFreshAPI = HelloFreshAPI()
    let dispatchGroup = DispatchGroup()
    let backgroundThread = DispatchQueue.global(qos: .background)
    let mainThread = DispatchQueue.main
    
    
    fileprivate func setUp() {
        self.view.backgroundColor = .red
        
        controllers = [recipeListViewController, favoritesVC, labVC]
        
        if let recipeListVC1 = controllers.first {
            self.setViewControllers([recipeListVC1], direction: .forward, animated: false, completion: nil)
        }
        
        // download recipe options
        self.retrieveHelloFreshMenu()
        
        // download recipes after downloading menu
        self.retrieveRecipeData()
    }
    
    
    fileprivate func retrieveRecipeData() {
        self.dispatchGroup.enter()
        let retrieveRecipeData = DispatchWorkItem {
            print(self.recipeListViewController.menuOptionsObj.menuOptions?.count)
            guard let menuOptions = self.recipeListViewController.menuOptionsObj.menuOptions else { return }
            
            for menuOption in menuOptions {
                print("initiate recipe download")
                print(menuOption)
                print()
//                print(menuOption.recipeLink)
                self.helloFreshAPI.retrieveRecipeInfo(urlString: menuOption.recipeLink, completion: { (recipe) in
                    print("download in progress")
                    print(self.recipeListViewController.menuOptionsObj.menuOptions?[0].recipeLink)
                    
                    // find index for recipe in menu options and attach recipe object
                    if let menuIndex = self.recipeListViewController.menuOptionsObj.menuOptions?.firstIndex(where: { $0.recipeLink == menuOption.recipeLink }) {
                        self.recipeListViewController.menuOptionsObj.menuOptions?[menuIndex].recipe = recipe
                        print("recipe downloaded")
                    }
                })
            }
            self.dispatchGroup.leave()
        }
        backgroundThread.async(group: dispatchGroup, execute: retrieveRecipeData)
        
//        dispatchGroup.notify(queue: backgroundThread) {
//            print("Complete - reloading menu option list with new data")
//            self.mainThread.async {
//                self.recipeListViewController.menuOptionList?.reloadData()
//            }
//        }
        
    }
    
    fileprivate func retrieveHelloFreshMenu() {
        self.dispatchGroup.enter()
        let retrieveMenuOptions = DispatchWorkItem {
            self.helloFreshAPI.retrieveMenuOptions(completion: { (data) in
                if let menuOptions = data as? [MenuOption] {
                    self.recipeListViewController.menuOptionsObj.menuOptions = menuOptions
                    print("menu options downloaded")
                    self.dispatchGroup.leave()
                }
            })
        }
        backgroundThread.async(group: dispatchGroup, execute: retrieveMenuOptions)
        self.dispatchGroup.wait()
    }
    
}


extension DashBoardController {

    internal func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = controllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = currentIndex + 1
        
        if nextIndex > (controllers.count - 1) {
            return nil
        } else {
            return controllers[nextIndex]
        }
    }
    
    internal func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = controllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = currentIndex - 1
        
        if previousIndex < 0 {
            return nil
        } else {
            return controllers[previousIndex]
        }
    }
    
}

