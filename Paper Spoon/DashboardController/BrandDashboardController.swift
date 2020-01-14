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
        
        self.createBrands()
        self.setUp()
        
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
            
            self.downloadData(brand: .HelloFresh)
//            self.downloadData(brand: .BlueApron)
//            self.downloadData(brand: .HomeChef)
            
            self.dispatchGroup.notify(queue: self.mainThread) {
                // update UI
                print("Updating HF UI")
                // only need to update the viewable viewController
                self.helloFreshViewController.menuOptionList.reloadData()
                // Stop activity indicator
                self.activityIndicator.activityEnded()
            }
        }
        
    }
    
    
    fileprivate func downloadData(brand: BrandType) {
        // download recipe options
        self.retrieveBrandMenu(brand: brand)
        
        // download recipes after downloading menu
        self.retrieveRecipeData(brand: brand)

        // download thumbnail after retrieving recipe data
        self.retrieveThumbnail(brand: brand)
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
            self.recipeListHeader.brandsPickerView.collectionView(self.recipeListHeader.brandsPickerView, didSelectItemAt: IndexPath(item: self.pageIndex!, section: 0))
            
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
        let recipeListHeader = RecipeListHeader(frame: CGRect(x: 0,
                                                              y: 0,
                                                              width: self.view.frame.width,
                                                              height: recipeHeaderHeightConstant))
        recipeListHeader.brandDashboardControllerDelegate = self
        return recipeListHeader
    }()
    
    lazy var helloFreshViewController: BrandViewController = {
        let helloFreshViewController = BrandViewController()
        helloFreshViewController.brandDashboardControllerDelegate = self
        helloFreshViewController.parentViewControllerDelegate = self.parentViewControllerDelegate
        helloFreshViewController.brandView = .HelloFresh
        helloFreshViewController.brand = self.brands?.first(where: { $0.name == .HelloFresh })
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
        blueApronViewController.parentViewControllerDelegate = self.parentViewControllerDelegate
        blueApronViewController.brandView = .BlueApron
        blueApronViewController.brand = self.brands?.first(where: { $0.name == .BlueApron })
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
    
    lazy var homeChefViewController: BrandViewController = {
        let homeChefViewController = BrandViewController()
        homeChefViewController.brandDashboardControllerDelegate = self
        homeChefViewController.parentViewControllerDelegate = self.parentViewControllerDelegate
        homeChefViewController.brandView = .HomeChef
        homeChefViewController.brand = self.brands?.first(where: { $0.name == .HomeChef })
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
    var compileIngredientsBtnCollapsed: [NSLayoutConstraint]?
    var compileIngredientsBtnCollapsedNoMenu: [NSLayoutConstraint]?
    var compileIngredientsBtnPopped: [NSLayoutConstraint]?
    var compileIngredientsBtnPoppedNoMenu: [NSLayoutConstraint]?
    var recipeHeaderHeightConstant: CGFloat = 100
    var recipeListHeaderTopConstraint: NSLayoutConstraint?
    var fingerTrailingAnchorClose: NSLayoutConstraint?
    var fingerTrailingAnchorFar: NSLayoutConstraint?
    var newMenuPromptCollapsed: [NSLayoutConstraint]?
    var newMenuPromptPopped: [NSLayoutConstraint]?
    
    // MARK: ScrollView variables
    // THIS SHOULD NOT CHANGE - buffer to add for nav bar height
    let headerBuffer: CGFloat = 34
    // vertical flex before a value is calculated to push recipeHeader up
    let verticalSpacer: CGFloat = 20
    // max push
    let maxVerticalSpacer: CGFloat = 65
    // calculate point at which push should occur
    var moveRecipeHeaderTrigger: CGFloat?
    var newFontSize: CGFloat?
    // point past maxVerticalSpacer to bring in blurView
    let blurStartPoint: CGFloat = 40
    
    // MARK: DispatchGroup variables
    var workItemCompletionCount: Int = 0
    var workItemCompletionLimit: Int = 0
    
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
        
        // animate tab bar back into view
        self.parentViewControllerDelegate?.fadeTabBar(fadePct: 1.0)
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
        
        // animate tab bar back into view
        self.parentViewControllerDelegate?.fadeTabBar(fadePct: 1.0)
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
        }
    }
}

