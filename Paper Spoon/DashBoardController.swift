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
        
        // download thumbnail after retrieving recipe data
        self.retrieveThumbnail()
        
        self.dispatchGroup.notify(queue: backgroundThread) {
            self.mainThread.async {
                // update UI
                print("Updating UI")
                self.recipeListViewController.menuOptionList.reloadData()
            }
        }
    }
    
    
    fileprivate func retrieveHelloFreshMenu() {
        self.dispatchGroup.enter()
        let retrieveMenuOptions = DispatchWorkItem {
            HelloFreshAPI.shared.retrieveMenuOptions(completion: { (data) in
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
    
    
    fileprivate func retrieveRecipeData() {
        let retrieveRecipeData = DispatchWorkItem {
            guard let menuOptions = self.recipeListViewController.menuOptionsObj.menuOptions else { return }
            
            // download recipe details for each menu option
            for menuOption in menuOptions {
                self.dispatchGroup.enter()
                HelloFreshAPI.shared.retrieveRecipeInfo(urlString: menuOption.recipeLink, completion: { (recipe) in
                    
                    // find index for recipe in menu options and attach recipe object
                    if let menuIndex = self.recipeListViewController.menuOptionsObj.menuOptions?.firstIndex(where: { $0.recipeLink == menuOption.recipeLink }) {
                        self.recipeListViewController.menuOptionsObj.menuOptions?[menuIndex].recipe = recipe
                        print("recipeDetails downloaded")
                        self.dispatchGroup.leave()
                    }
                })
            }
            
        }
        backgroundThread.async(group: dispatchGroup, execute: retrieveRecipeData)
        self.dispatchGroup.wait()
    }
    
    fileprivate func retrieveThumbnail() {
        let retrieveThumbnail = DispatchWorkItem {
            guard let menuOptions = self.recipeListViewController.menuOptionsObj.menuOptions else { return }
            
            // download thumbnail for each menu option
            for menuOption in menuOptions {
                print("grabbing thumbnail link")
                self.dispatchGroup.enter()
                if let thumbnailLink = menuOption.recipe?.thumbnailLink {
                    ImageAPI.shared.downloadImage(urlLink: thumbnailLink, completion: { (thumbnailData) in
                        if let menuIndex = self.recipeListViewController.menuOptionsObj.menuOptions?.firstIndex(where: { $0.recipeLink == menuOption.recipeLink }) {
                            self.recipeListViewController.menuOptionsObj.menuOptions?[menuIndex].recipe?.thumbnail = UIImage(data: thumbnailData)
                            print("thumbnail")
                            self.dispatchGroup.leave()
                        }
                    })
                }
            }
        }
        backgroundThread.async(group: dispatchGroup, execute: retrieveThumbnail)
        
        /*
         !!!!!
         DO NOT DISPATCH GROUP WAIT AS IT IS LAST TASK
         !!!!!
        */
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

