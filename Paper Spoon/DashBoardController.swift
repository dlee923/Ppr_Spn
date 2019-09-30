//
//  ViewController.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 11/11/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

class DashBoardController: UIPageViewController {
    
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
        self.createBrands()
        self.addRecipeListHeader()
        
        // pass brands data to header
        recipeListHeader.brands = self.brands
        
        // Add activity indicator
        self.mainThread.async {
//            self.dispatchGroup.enter()
            self.activityindicator.activityInProgress()
//            self.dispatchGroup.leave()
        }
        
        self.downloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    lazy var recipeListHeader = RecipeListHeader(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
    
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
    
    let activityindicator = ActivityIndicator()
    let dispatchGroup = DispatchGroup()
    let backgroundThread = DispatchQueue.global(qos: .background)
    let mainThread = DispatchQueue.main
    var brands: [Brand]?
    
    fileprivate func setUp() {
        self.view.backgroundColor = UIColor.themeColor1
        
        controllers = [recipeListViewController, favoritesVC, labVC]
        
        if let recipeListVC1 = controllers.first {
            self.setViewControllers([recipeListVC1], direction: .forward, animated: false, completion: nil)
        }
    }
    
    
    fileprivate func downloadData() {
        // download recipe options
        self.retrieveHelloFreshMenu()
        
        // download recipes after downloading menu
        self.retrieveRecipeData()
        
        // download thumbnail after retrieving recipe data
        self.retrieveThumbnail()
        
        self.dispatchGroup.notify(queue: self.mainThread) {
            // update UI
            print("Updating UI")
            self.recipeListViewController.menuOptionList.reloadData()
            // Stop activity indicator
            self.activityindicator.activityEnded()
        }
    }
    
    
    fileprivate func retrieveHelloFreshMenu() {
        let retrieveMenuOptions = DispatchWorkItem {
            HelloFreshAPI.shared.retrieveMenuOptions(completion: { (data) in
                if let menuOptions = data as? [MenuOption] {
                    self.recipeListViewController.menuOptionsObj.menuOptions = menuOptions
                    print("menu options downloaded")
                    self.dispatchGroup.leave()
                }
            })
        }
        self.dispatchGroup.enter()
        backgroundThread.async(group: dispatchGroup, execute: retrieveMenuOptions)
        self.dispatchGroup.wait()
    }
    
    
    fileprivate func retrieveRecipeData() {
        guard let menuOptions = self.recipeListViewController.menuOptionsObj.menuOptions else { return }
        
        // download recipe details for each menu option
        for menuOption in menuOptions {
            let retrieveRecipeData = DispatchWorkItem {
                HelloFreshAPI.shared.retrieveRecipeInfo(urlString: menuOption.recipeLink, completion: { (recipe) in
                    
                    // find index for recipe in menu options and attach recipe object
                    if let menuIndex = self.recipeListViewController.menuOptionsObj.menuOptions?.firstIndex(where: { $0.recipeLink == menuOption.recipeLink }) {
                        self.recipeListViewController.menuOptionsObj.menuOptions?[menuIndex].recipe = recipe
                        self.dispatchGroup.leave()
                    }
                })
            }
            self.dispatchGroup.enter()
            self.backgroundThread.async(group: dispatchGroup, execute: retrieveRecipeData)
            self.dispatchGroup.wait()
        }
    }
    
    fileprivate func retrieveThumbnail() {
        guard let menuOptions = self.recipeListViewController.menuOptionsObj.menuOptions else { return }
        
        // download thumbnail for each menu option
        for menuOption in menuOptions {
            let retrieveThumbnail = DispatchWorkItem {
                
                if let thumbnailLink = menuOption.recipe?.thumbnailLink {
                    ImageAPI.shared.downloadImage(urlLink: thumbnailLink, completion: { (thumbnailData) in
                        if let menuIndex = self.recipeListViewController.menuOptionsObj.menuOptions?.firstIndex(where: { $0.recipeLink == menuOption.recipeLink }) {
                            self.recipeListViewController.menuOptionsObj.menuOptions?[menuIndex].recipe?.thumbnail = UIImage(data: thumbnailData)
                            self.dispatchGroup.leave()
                        }
                    })
                }
                
            }
            self.dispatchGroup.enter()
            backgroundThread.async(group: dispatchGroup, execute: retrieveThumbnail)
        }
        
        /*
         !!!!!
         DO NOT DISPATCH GROUP WAIT AS IT IS LAST TASK
         !!!!!
        */
    }
    
    private func addRecipeListHeader() {
        self.view.addSubview(self.recipeListHeader)
        self.recipeListHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.recipeListHeader.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.recipeListHeader.heightAnchor.constraint(equalToConstant: 100),
            self.recipeListHeader.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
            self.recipeListHeader.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5)
        ])
    }
    
    private func createBrands() {
        let helloFresh = Brand(name: .HelloFresh, image: UIImage(named: "hellofresh_x1.png")!)
        let blueApron = Brand(name: .BlueApron, image: UIImage(named: "blueapron_x1.png")!)
        let everyPlate = Brand(name: .EveryPlate, image: UIImage(named: "plated_x1.png")!)
        let homeChef = Brand(name: .HomeChef, image: UIImage(named: "homechef_x1.png")!)
//        let plated = Brand(name: .Plated, image: UIImage(named: "plated_x1.png")!)
//        let purpleCarrot = Brand(name: .PurpleCarrot, image: UIImage(named: "plated_x1.png")!)
        
        self.brands = [
            helloFresh,
            blueApron,
            everyPlate,
            homeChef
        ]
    }

}


extension DashBoardController: UIPageViewControllerDataSource{

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


protocol MovePickerPositionDelegate: AnyObject {
    func movePickerPosition(position: Int)
}

extension DashBoardController: MovePickerPositionDelegate {
    func movePickerPosition(position: Int) {
        
    }
}
