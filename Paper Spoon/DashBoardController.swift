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
    
    var recipeListVC: UIViewController = {
        let recipeListVC = UIViewController()
        recipeListVC.view.backgroundColor = .yellow
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
    let dispatchQueue = DispatchQueue.global(qos: .background)
    
    var menuOptions = [MenuOption]()
    
    
    fileprivate func setUp() {
        self.view.backgroundColor = .red
        
        controllers = [recipeListVC, favoritesVC, labVC]
        
        if let recipeListVC1 = controllers.first {
            self.setViewControllers([recipeListVC1], direction: .forward, animated: false, completion: nil)
        }
    }
    
    fileprivate func retrieveRecipeData() {
        let retrieveRecipeData = DispatchWorkItem {
            for menuOption in self.menuOptions {
                self.dispatchGroup.enter()
                self.helloFreshAPI.retrieveRecipeInfo(urlString: menuOption.recipeLink, completion: { (data) in
                    if let recipe = data as? Recipe {
                        
                    }
                    self.dispatchGroup.leave()
                })
            }
        }
        
        dispatchQueue.async(group: dispatchGroup, execute: retrieveRecipeData)
        
    }
    
    fileprivate func retrieveHelloFreshMenu() {
        let retrieveMenuOptions = DispatchWorkItem {
            self.dispatchGroup.enter()
            self.helloFreshAPI.retrieveMenuOptions(completion: { (data) in
                if let menuOptions = data as? [MenuOption] {
                    self.menuOptions = menuOptions
                }
                self.dispatchGroup.leave()
            })
        }
        
        dispatchQueue.async(group: dispatchGroup, execute: retrieveMenuOptions)
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

