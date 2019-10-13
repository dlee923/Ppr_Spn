//
//  RecipeListViewController.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/4/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class BrandViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        // Do any additional setup after loading the view.
        
        // add compile ingredients btn
        self.setupCompileIngredientsBtn()
        self.addCompileIngredientsBtn()
        
        // add menu option list to view
        self.setupMenuOptionsList()
        self.addViewMenuOptionList()
    }
    
    private func setup() {
        self.setColors()
    }
    
    // MARK:  Variables
    var menuOptionList: MenuOptionList!
    var compileIngredientsBtn: NextStepBtn?
    var menuOptionsObj = MenuOptionObj(menuOptions: nil)
    var compiledIngredients = [Ingredients]()
    var reducedCompiledIngredients = [Ingredients]()
    
    let dispatchGroup = DispatchGroup()
    let mainThread = DispatchQueue.main
    let backgroundThread = DispatchQueue.global(qos: .background)
    let activityIndicator = ActivityIndicator()
    
    // MARK:  Animatable constraints
    var compileIngredientsBtnHeightCollapsed: NSLayoutConstraint?
    var compileIngredientsBtnExpanded: NSLayoutConstraint?
    
    private func setColors() {
        self.view.backgroundColor = UIColor.themeColor1
    }
    
    private func setupMenuOptionsList() {
        self.menuOptionList = MenuOptionList(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.menuOptionList.menuOptionsObj = self.menuOptionsObj
        self.menuOptionList.brandViewControllerDelegate = self
    }
    
    private func addViewMenuOptionList(){
        self.view.addSubview(self.menuOptionList)
        
        self.menuOptionList?.translatesAutoresizingMaskIntoConstraints = false
        self.menuOptionList?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        self.menuOptionList?.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5).isActive = true
        self.menuOptionList?.bottomAnchor.constraint(equalTo: self.compileIngredientsBtn?.topAnchor ?? self.view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        self.menuOptionList?.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
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

}


protocol BrandViewControllerDelegate: AnyObject {
    func showHideCompileButton()
}


extension BrandViewController: BrandViewControllerDelegate {
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
    }
}
