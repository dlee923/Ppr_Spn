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
        
        // add compile ingredients View + Button
        self.addCompileIngredientsView()
        self.setupCompileIngredientsBtn()
        self.addCompileIngredientsBtn()
        self.addFingerPointer()
        
        // pass brands data to header
        recipeListHeader.brands = self.brands
        
        // Add activity indicator
        DispatchQueue.main.async {
            self.activityIndicator.activityInProgress()
        }

        // must wrap in a background thread in order to avoid pausing the launch screen
        DispatchQueue.global().async {
            
//            self.downloadData(brand: .HelloFresh)
//            self.downloadData(brand: .BlueApron)
            self.downloadData(brand: .HomeChef)
            
            self.dispatchGroup.notify(queue: self.mainThread) {
                // update UI
                print("Updating HF UI")
                self.helloFreshViewController.menuOptionList.reloadData()
                // Stop activity indicator
                self.activityIndicator.activityEnded()
            }
        }
        
    }
    
    
    fileprivate func downloadData(brand: BrandType) {
        // download recipe options
        self.retrieveBrandMenu(brand: brand)
        
//        // download recipes after downloading menu
//        self.retrieveRecipeData(brand: brand)
//
//        // download thumbnail after retrieving recipe data
//        self.retrieveThumbnail(brand: brand)
    }
    
    
    // MARK: App Settings
    let recipeMaxCount = 5
    
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
    var tempSelectedMenuOptions: [MenuOption]?
    
    // MARK: UI Elements
    var compileIngredientsBtn: NextStepBtn?
    let compileIngredientsBtnHeight: CGFloat = 0.05
    var compileIngredientsView = UIView()
    let activityIndicator = ActivityIndicator()
    
    lazy var recipeListHeader: RecipeListHeader = {
        let recipeListHeader = RecipeListHeader(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        recipeListHeader.brandDashboardControllerDelegate = self
        return recipeListHeader
    }()
    
    lazy var helloFreshViewController: BrandViewController = {
        let helloFreshViewController = BrandViewController()
        helloFreshViewController.brandDashboardControllerDelegate = self
        helloFreshViewController.brandView = .HelloFresh
        helloFreshViewController.menuOptionsObj = self.menuOptionsObj
        
        // pass to each view controller?
        if let compileIngredientsBtnHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height {
            helloFreshViewController.menuOptionListExpandedConstant = self.compileIngredientsBtnHeight * CGFloat(compileIngredientsBtnHeight) + 5
        }
        
        return helloFreshViewController
    }()
    
    lazy var blueApronViewController: BrandViewController = {
        let blueApronViewController = BrandViewController()
        blueApronViewController.brandDashboardControllerDelegate = self
        blueApronViewController.brandView = .BlueApron
        blueApronViewController.menuOptionsObj = self.menuOptionsObj
        
        // pass to each view controller?
        if let compileIngredientsBtnHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height {
            blueApronViewController.menuOptionListExpandedConstant = self.compileIngredientsBtnHeight * CGFloat(compileIngredientsBtnHeight) + 5
        }
        
        return blueApronViewController
    }()
    
    var platedViewController: UIViewController = {
        let labVC = UIViewController()
        return labVC
    }()
    
    lazy var homeChefViewController: UIViewController = {
        let homeChefViewController = BrandViewController()
        homeChefViewController.brandDashboardControllerDelegate = self
        homeChefViewController.brandView = .HomeChef
        homeChefViewController.menuOptionsObj = self.menuOptionsObj
        
        // pass to each view controller?
        if let compileIngredientsBtnHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height {
            homeChefViewController.menuOptionListExpandedConstant = self.compileIngredientsBtnHeight * CGFloat(compileIngredientsBtnHeight) + 5
        }
        
        return homeChefViewController
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
    var recipeHeaderHeight: NSLayoutConstraint?
    var recipeHeaderHeightConstant: CGFloat = 100
    var fingerTrailingAnchorClose: NSLayoutConstraint?
    var fingerTrailingAnchorFar: NSLayoutConstraint?
    var newMenuPromptCollapsed: [NSLayoutConstraint]?
    var newMenuPromptPopped: [NSLayoutConstraint]?
    
    fileprivate func setUp() {
        controllers = [helloFreshViewController, blueApronViewController, platedViewController, homeChefViewController]
        
        if let recipeListVC1 = controllers.first {
            self.setViewControllers([recipeListVC1], direction: .forward, animated: false, completion: nil)
        }
    }
    
    fileprivate func retrieveBrandMenu(brand: BrandType) {
        var brandAPI: BrandAPI?
        
        switch brand {
        case .HelloFresh : brandAPI = HelloFreshAPI.shared
        case .BlueApron : brandAPI = BlueApronAPI.shared
        case .HomeChef :  brandAPI = HomeChefAPI.shared
        default: return
        }
        
        let retrieveMenuOptions = DispatchWorkItem {
            brandAPI?.retrieveMenuOptions(completion: { (data) in
                if let menuOptions = data as? [MenuOption] {
                    self.menuOptionsObj?.menuOptions[brand] = menuOptions
                    self.dispatchGroup.leave()
                }
            })
        }
        self.dispatchGroup.enter()
        
        backgroundThread.async(group: dispatchGroup, execute: retrieveMenuOptions)
        self.dispatchGroup.wait()
    }
    
    
    fileprivate func retrieveRecipeData(brand: BrandType) {
        guard let menuOptions = self.menuOptionsObj?.menuOptions[brand] else { return }
        var menuOptionsCount = 0
        var brandAPI: BrandAPI?
        
        switch brand {
        case .HelloFresh : brandAPI = HelloFreshAPI.shared
        case .BlueApron : brandAPI = BlueApronAPI.shared
        case .HomeChef :  brandAPI = HomeChefAPI.shared
        default: return
        }
        
        // download recipe details for each menu option
        for menuOption in menuOptions {
            let retrieveRecipeData = DispatchWorkItem {
                brandAPI?.retrieveRecipeInfo(urlString: menuOption.recipeLink, completion: { (recipe) in
                    
                    // find index for recipe in menu options and attach recipe object
                    if let menuIndex = self.menuOptionsObj?.menuOptions[brand]?.firstIndex(where: { $0.recipeLink == menuOption.recipeLink }) {
                        self.menuOptionsObj?.menuOptions[brand]?[menuIndex].recipe = recipe
                        
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
    
    
    fileprivate func retrieveThumbnail(brand: BrandType) {
        guard let menuOptions = self.menuOptionsObj?.menuOptions[brand] else { return }
        
        // download thumbnail for each menu option
        for menuOption in menuOptions {
            let retrieveThumbnail = DispatchWorkItem {
                
                if let thumbnailLink = menuOption.recipe?.thumbnailLink {
                    ImageAPI.shared.downloadImage(urlLink: thumbnailLink, completion: { (thumbnailData) in
                        if let menuIndex = self.menuOptionsObj?.menuOptions[brand]?.firstIndex(where: { $0.recipeLink == menuOption.recipeLink }) {
                            self.menuOptionsObj?.menuOptions[brand]?[menuIndex].recipe?.thumbnail = UIImage(data: thumbnailData)

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
        
        // reset compiledIngredients
        self.compiledIngredients.removeAll()
        
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
    
    
    private func allocateIngredientImages() {
        guard let selectedMenuOptions = self.menuOptionsObj?.selectedMenuOptions else { return }
        
        for menuOption in selectedMenuOptions {
            if let ingredients = menuOption.recipe?.ingredients {
                for ingredient in ingredients {
                    let ingredientImg = self.reducedCompiledIngredients.first(where: { $0.name == ingredient.name })
                    ingredient.image = ingredientImg?.image
                }
            }
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
        
        guard let temporarySelectedMenuOptions = self.tempSelectedMenuOptions else { return }
        
        if temporarySelectedMenuOptions.count <= 0 { return }
        
        self.menuOptionsObj?.selectedMenuOptions = temporarySelectedMenuOptions
        
        // inject compiled ingredients list
        self.calculateIngredients {
            
            // find number of ingredients that only have a picture source
            let reducedCompiledIngredientsCount = self.reducedCompiledIngredients.filter({ $0.imageLink != nil }).count
            let selectedMenuOptionsCount = self.menuOptionsObj?.selectedMenuOptions.filter({ $0.recipe?.recipeImageLink != nil }).count ?? 0
            
            // reset work item completions:
            self.workItemCompletionCount = 0
            self.workItemCompletionLimit = reducedCompiledIngredientsCount + selectedMenuOptionsCount
            
            // download ingredients images
            self.downloadIngredientImages()
            
            // download recipe images
            self.downloadRecipeImages()
            
            dispatchGroup.notify(queue: mainThread, execute: {
                self.parentViewControllerDelegate?.sendReducedCompiledIngredients(reducedCompiledIngredients: self.reducedCompiledIngredients, completion: {
                    // attach ingredient images to MenuOption recipe ingredient images
                    self.allocateIngredientImages()
                    
                    // present compiledIngredientsViewController
                    self.activityIndicator.activityEnded()
                    self.parentViewControllerDelegate?.changeViewController(index: 1)
                })
            })
        }
    }
    
    // prompt creating menu name
    @objc internal func createNewMenuPrompt() {
        let newMenuPrompt = NewMenuPrompt()
        newMenuPrompt.brandDashboardControllerTransitionsDelegate = self
        newMenuPrompt.translatesAutoresizingMaskIntoConstraints = false
        newMenuPromptPopped = [
            newMenuPrompt.topAnchor.constraint(equalTo: self.view.topAnchor),
            newMenuPrompt.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            newMenuPrompt.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            newMenuPrompt.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        
        newMenuPromptCollapsed = [
            newMenuPrompt.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            newMenuPrompt.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            newMenuPrompt.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5),
            newMenuPrompt.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5)
        ]
        
        self.view.addSubview(newMenuPrompt)
        
        guard let newMenuPromptCollapsed = self.newMenuPromptCollapsed else { return }
        NSLayoutConstraint.activate(newMenuPromptCollapsed)
        newMenuPrompt.alpha = 0.2
        
        self.view.layoutIfNeeded()
        
        guard let newMenuPromptPopped = self.newMenuPromptPopped else { return }
        NSLayoutConstraint.deactivate(newMenuPromptCollapsed)
        NSLayoutConstraint.activate(newMenuPromptPopped)
        
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.9, options: .curveEaseOut, animations: {
            newMenuPrompt.alpha = 1.0
            
            self.view.layoutIfNeeded()
        }, completion: { (_) in
            
        })
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

