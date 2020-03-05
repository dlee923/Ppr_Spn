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
        
        // pass brands data to header
        recipeListHeader.brands = self.brands
        
        // Add activity indicator
        DispatchQueue.main.async {
            self.activityIndicator.activityInProgress()
        }

        // must wrap in a background thread in order to avoid pausing the launch screen
        DispatchQueue.global().async {
            
//            self.downloadData(brand: .HelloFresh)
            self.downloadData(brand: .HomeChef)
//            self.downloadData(brand: .BlueApron)
            
            
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
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.compileIngredientsView.startPulseAnimation()
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
    lazy var compileIngredientsView = NextStepBtnView(frame: self.view.frame)
    let activityIndicator = ActivityIndicator()
    
    lazy var recipeListHeader: RecipeListHeader = {
        let recipeListHeader = RecipeListHeader(frame: CGRect(x: 0,
                                                              y: 0,
                                                              width: self.view.frame.width - 10,
                                                              height: recipeHeaderHeightConstant))
        recipeListHeader.brandDashboardControllerDelegate = self
        return recipeListHeader
    }()
    
    var helloFreshViewController = BrandViewController()
    var blueApronViewController = BrandViewController()
    var platedViewController = BrandViewController()
    var homeChefViewController = BrandViewController()
    
    // MARK: Multi-threading
    let dispatchGroup = DispatchGroup()
    let backgroundThread = DispatchQueue(label: "backgroundThread")
    let mainThread = DispatchQueue.main
    
    // MARK: Delegates
    var parentViewControllerDelegate: ParentViewControllerDelegate?
    
    // MARK:  Animatable constraints
    // for use in animating button location in relation to tab bar
    var compileIngredientsBtnCollapsed: [NSLayoutConstraint]?
    var compileIngredientsBtnCollapsedNoMenu: [NSLayoutConstraint]?
    var compileIngredientsBtnPopped: [NSLayoutConstraint]?
    var compileIngredientsBtnPoppedNoMenu: [NSLayoutConstraint]?
    // for use in recipe header
    var recipeHeaderHeightConstant: CGFloat = 100
    var recipeListHeaderTopConstraint: NSLayoutConstraint?
    
    var newMenuPromptCollapsed: [NSLayoutConstraint]?
    var newMenuPromptPopped: [NSLayoutConstraint]?
    // for use in animating selected options view
    var selectedOptionsOpen: NSLayoutConstraint?
    var selectedOptionsClosed: NSLayoutConstraint?
    
    
    // MARK: ScrollView variables
    // THIS SHOULD NOT CHANGE - buffer to add for nav bar height
    let headerBuffer: CGFloat = 34
    // vertical flex before a value is calculated to push recipeHeader up
    let verticalSpacer: CGFloat = 20
    // max push
    let maxVerticalSpacer: CGFloat = 65
    // calculate point at which push should occur
    var moveRecipeHeaderTrigger: CGFloat?
    var newRecipeListHeaderSize: CGFloat?
    // point past maxVerticalSpacer to bring in blurView
    let blurStartPoint: CGFloat = 40
    
    // MARK: DispatchGroup variables
    var workItemCompletionCount: Int = 0
    var workItemCompletionLimit: Int = 0

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

