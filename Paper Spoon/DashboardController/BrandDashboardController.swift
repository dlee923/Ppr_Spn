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
        DispatchQueue.main.async {
            self.activityIndicator.activityInProgress()
        }

        self.downloadData()
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
    var menuOptionsObj = MenuOptionObj(menuOptions: nil)
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
        return recipeListVC
    }()
    
    var blueApronViewController: UIViewController = {
        let favoritesVC = UIViewController()
        favoritesVC.view.backgroundColor = .white
        return favoritesVC
    }()
    
    var platedViewController: UIViewController = {
        let labVC = UIViewController()
        labVC.view.backgroundColor = .gray
        return labVC
    }()
    
    var homeChefViewController: UIViewController = {
        let homeChefVC = UIViewController()
        homeChefVC.view.backgroundColor = .green
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
    var compileIngredientsBtnExpanded: NSLayoutConstraint?
    
    
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
    
    // button action to proceed to shopping list screen
    @objc private func transitionCompileIngredientsView() {
        if self.menuOptionsObj.menuOptions == nil {
            // prompt warning?
            return
        }
        if self.menuOptionsObj.selectedMenuOptions.count <= 0 { return }
        let compiledIngredientsViewController = CompileIngredientsViewController()
        compiledIngredientsViewController.menuOptionsObj = self.menuOptionsObj
        
        // inject compiled ingredients list
        self.calculateIngredients {
            
            self.downloadIngredientImages()
            
            dispatchGroup.notify(queue: mainThread, execute: {
                compiledIngredientsViewController.reducedCompiledIngredients = self.reducedCompiledIngredients
                // present compiledIngredientsViewController
                self.activityIndicator.activityEnded()
                self.present(compiledIngredientsViewController, animated: true, completion: nil)
            })
        }
    }
    
    private func calculateIngredients(completion: () -> ()) {
        // aggregate all ingredients from selected recipes
        let selectedMenuOptions = self.menuOptionsObj.selectedMenuOptions
        
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
    
    private func downloadIngredientImages() {
        self.mainThread.async {
            self.activityIndicator.activityInProgress()
        }
        
        var workItemCompletionCount: Int = 0
        
        self.dispatchGroup.enter()
        for x in 0..<self.reducedCompiledIngredients.count {
            let dispatchWorkItem = DispatchWorkItem(block: {
                print(self.reducedCompiledIngredients[x].imageLink!)
                ImageAPI.shared.downloadImage(urlLink: self.reducedCompiledIngredients[x].imageLink!, completion: {
                    self.reducedCompiledIngredients[x].image = UIImage(data: $0)
                    workItemCompletionCount += 1
                    print("\(workItemCompletionCount) / \(self.reducedCompiledIngredients.count)")
                    if workItemCompletionCount == self.reducedCompiledIngredients.count {
                        print("done")
                        self.dispatchGroup.leave()
                        
                    }
                })
            })
            self.backgroundThread.async(group: self.dispatchGroup, execute: dispatchWorkItem)
        }
    }

}

// MARK: Setting up views
extension BrandDashboardController {
    
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
    
    private func setupCompileIngredientsBtn() {
        self.compileIngredientsBtn = NextStepBtn(frame: CGRect(x: 0, y: 0,
                                                               width: self.view.frame.width,
                                                               height: self.view.frame.height * 0.1),
                                                 setTitle: "Compile Ingredients!")
        self.compileIngredientsBtn?.addTarget(self, action: #selector(transitionCompileIngredientsView), for: .touchUpInside)
    }
    
    private func addCompileIngredientsBtn() {
        self.compileIngredientsBtn?.layer.cornerRadius = 5
        self.view.addSubview(self.compileIngredientsBtn ?? UIView())
        
        self.compileIngredientsBtn?.translatesAutoresizingMaskIntoConstraints = false
        self.compileIngredientsBtn?.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        self.compileIngredientsBtn?.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5).isActive = true
        self.compileIngredientsBtn?.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        
        self.compileIngredientsBtnExpanded = self.compileIngredientsBtn?.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1)
        
        self.compileIngredientsBtnHeightCollapsed = self.compileIngredientsBtn?.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.0)
        
        self.compileIngredientsBtnHeightCollapsed?.isActive = true
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


protocol BrandDashboardControllerDelegate: AnyObject {
    func showHideCompileButton()
    func movePickerPosition(position: Int)
}


extension BrandDashboardController: BrandDashboardControllerDelegate {
    
    func showHideCompileButton() {
        guard let compileIngredientsButtonHeightCollapsed = self.compileIngredientsBtnHeightCollapsed else { return }
        if self.menuOptionsObj.selectedMenuOptions.count == 1 {
            if compileIngredientsButtonHeightCollapsed.isActive == true {
                self.compileIngredientsBtnHeightCollapsed?.isActive = false
                self.compileIngredientsBtnExpanded?.isActive = true
            }
        } else if self.menuOptionsObj.selectedMenuOptions.count == 0 {
            if compileIngredientsButtonHeightCollapsed.isActive == false {
                self.compileIngredientsBtnExpanded?.isActive = false
                self.compileIngredientsBtnHeightCollapsed?.isActive = true
            }
        }
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.9, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func movePickerPosition(position: Int) { }
}
