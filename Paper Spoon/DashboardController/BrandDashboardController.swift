//
//  ViewController.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 11/11/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

class BrandDashboardController: UIPageViewController {
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewController.OptionsKey.spineLocation: UIPageViewController.SpineLocation.mid])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        self.setUp()
        self.createBrands()
        
        // add ui views
        
        self.addRecipeListHeader()
        // add compile ingredients btn
        self.setupCompileIngredientsBtn()
        self.addCompileIngredientsBtn()
        
        // pass brands data to header
        recipeListHeader.brands = self.brands
        
        // Add activity indicator
//        DispatchQueue.main.async {
//            self.activityIndicator.activityInProgress()
//        }
//
//        self.downloadData()
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
            self.activityIndicator.activityEnded()
        }
    }
    
    // MARK: Variables
    var menuOptionsObj: MenuOptionObj?
    var controllers = [UIViewController]()
    var compiledIngredients = [Ingredients]()
    var reducedCompiledIngredients = [Ingredients]()
    var brands: [Brand]?
    
    var pageIndex: Int? {
        didSet {
            self.recipeListHeader.moveBrandsSelectorView(index: self.pageIndex!)
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
                self.recipeListHeader.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    private var pendingPageIndex: Int?
    
    // MARK: UI Elements
    var compileIngredientsBtn: NextStepBtn?
    let activityIndicator = ActivityIndicator()
    
    lazy var recipeListHeader = RecipeListHeader(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
    
    lazy var recipeListViewController: BrandViewController = {
        let recipeListVC = BrandViewController()
        recipeListVC.brandDashboardControllerDelegate = self
        recipeListVC.menuOptionsObj = self.menuOptionsObj
        
        // pass to each view controller?
        if let compileIngredientsBtnHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height {
            recipeListVC.menuOptionListExpandedConstant = compileIngredientsBtnHeight * CGFloat(0.1)
        }
        return recipeListVC
    }()
    
    var blueApronViewController: UIViewController = {
        let favoritesVC = UIViewController()
        favoritesVC.view.backgroundColor = UIColor.themeColor1
        return favoritesVC
    }()
    
    var platedViewController: UIViewController = {
        let labVC = UIViewController()
        labVC.view.backgroundColor = UIColor.themeColor1
        return labVC
    }()
    
    var homeChefViewController: UIViewController = {
        let homeChefVC = UIViewController()
        homeChefVC.view.backgroundColor = UIColor.themeColor1
        return homeChefVC
    }()
    
    // MARK: Multi-threading
    let dispatchGroup = DispatchGroup()
    let backgroundThread = DispatchQueue(label: "backgroundThread")
    let mainThread = DispatchQueue.main
    
    // MARK: Delegates
    var parentViewControllerDelegate: ParentViewControllerDelegate?
    
    // MARK:  Animatable constraints
    var compileIngredientsBtnHeightCollapsed: NSLayoutConstraint?
    var compileIngredientsBtnPopped: NSLayoutConstraint?
    var compileIngredientsBtnExpanded: NSLayoutConstraint?
    var compileIngredientsBtnNarrowed: NSLayoutConstraint?
    
    fileprivate func setUp() {
        self.view.backgroundColor = UIColor.themeColor1
        
        controllers = [recipeListViewController, blueApronViewController, platedViewController, homeChefViewController]
        
        if let recipeListVC1 = controllers.first {
            self.setViewControllers([recipeListVC1], direction: .forward, animated: false, completion: nil)
        }
    }
    
    
    fileprivate func retrieveHelloFreshMenu() {
        let retrieveMenuOptions = DispatchWorkItem {
            HelloFreshAPI.shared.retrieveMenuOptions(completion: { (data) in
                if let menuOptions = data as? [MenuOption] {
                    self.recipeListViewController.menuOptionsObj?.menuOptions = menuOptions
                    self.dispatchGroup.leave()
                }
            })
        }
        self.dispatchGroup.enter()
        
        backgroundThread.async(group: dispatchGroup, execute: retrieveMenuOptions)
        self.dispatchGroup.wait()
    }
    
    
    fileprivate func retrieveRecipeData() {
        guard let menuOptions = self.recipeListViewController.menuOptionsObj?.menuOptions else { return }
        var menuOptionsCount = 0
        // download recipe details for each menu option
        for menuOption in menuOptions {
            let retrieveRecipeData = DispatchWorkItem {
                HelloFreshAPI.shared.retrieveRecipeInfo(urlString: menuOption.recipeLink, completion: { (recipe) in
                    
                    // find index for recipe in menu options and attach recipe object
                    if let menuIndex = self.recipeListViewController.menuOptionsObj?.menuOptions?.firstIndex(where: { $0.recipeLink == menuOption.recipeLink }) {
                        self.recipeListViewController.menuOptionsObj?.menuOptions?[menuIndex].recipe = recipe
                        
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
    
    
    fileprivate func retrieveThumbnail() {
        guard let menuOptions = self.recipeListViewController.menuOptionsObj?.menuOptions else { return }
        
        // download thumbnail for each menu option
        for menuOption in menuOptions {
            let retrieveThumbnail = DispatchWorkItem {
                
                if let thumbnailLink = menuOption.recipe?.thumbnailLink {
                    ImageAPI.shared.downloadImage(urlLink: thumbnailLink, completion: { (thumbnailData) in
                        if let menuIndex = self.recipeListViewController.menuOptionsObj?.menuOptions?.firstIndex(where: { $0.recipeLink == menuOption.recipeLink }) {
                            self.recipeListViewController.menuOptionsObj?.menuOptions?[menuIndex].recipe?.thumbnail = UIImage(data: thumbnailData)

                            self.dispatchGroup.leave()
                        }
                    })
                }
                
            }
            self.dispatchGroup.enter()
            backgroundThread.async(group: dispatchGroup, execute: retrieveThumbnail)
        }
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
    
    private func calculateIngredients(completion: () -> ()) {
        // aggregate all ingredients from selected recipes
        guard let selectedMenuOptions = self.menuOptionsObj?.selectedMenuOptions else { return }
        
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
    
    var workItemCompletionCount: Int = 0
    var workItemCompletionLimit: Int = 0
    
    private func downloadIngredientImages() {
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
    
    private func downloadRecipeImages() {
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
    
    // button action to proceed to shopping list screen
    @objc internal func transitionCompileIngredientsView() {
        if self.menuOptionsObj?.menuOptions == nil {
            // prompt warning?
            return
        }
        
        if self.menuOptionsObj?.selectedMenuOptions.count ?? 0 <= 0 { return }
        
        // inject compiled ingredients list
        self.calculateIngredients {
            
            // find number of ingredients that only have a picture source
            let reducedCompiledIngredientsCount = self.reducedCompiledIngredients.filter({ $0.imageLink != nil }).count
            let selectedMenuOptionsCount = self.menuOptionsObj?.selectedMenuOptions.filter({ $0.recipe?.recipeImageLink != nil }).count ?? 0
            
            self.workItemCompletionLimit = reducedCompiledIngredientsCount + selectedMenuOptionsCount
            
            // download ingredients images
            self.downloadIngredientImages()
            
            // download recipe images
            self.downloadRecipeImages()
            
            dispatchGroup.notify(queue: mainThread, execute: {
                self.parentViewControllerDelegate?.sendReducedCompiledIngredients(reducedCompiledIngredients: self.reducedCompiledIngredients, completion: {
                    // present compiledIngredientsViewController
                    self.activityIndicator.activityEnded()
                    self.parentViewControllerDelegate?.changeViewController(index: 1)
                })
            })
        }
    }

}


extension BrandDashboardController: UIPageViewControllerDataSource{

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

extension BrandDashboardController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingPageIndex = self.controllers.firstIndex(of: pendingViewControllers.first!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            self.pageIndex = self.pendingPageIndex
            if let index = self.pageIndex {
                print(index)
            }
        }
    }
}

