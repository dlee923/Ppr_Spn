//
//  CompileIngredientsViewController.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/17/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class CompileIngredientsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    private func setup() {
        self.setColors()
        
        self.setupFinishedShoppingBtn()
        self.addFinishedShoppingBtn()
        
        self.setupCompiledIngredientsList()
        self.addCompiledIngredientsList()
        
        self.calculateIngredients()
        self.injectCompiledIngredientsList()
    }
    
    var compiledIngredientsList: CompiledIngredientsList?
    var menuOptionsObj: MenuOptionObj?
    var compiledIngredients = [Ingredients]()
    var reducedCompiledIngredients = [Ingredients]()
    var finishedShoppingBtn: NextStepBtn?
    
    let dispatchGroup = DispatchGroup()
    let backgroundThread = DispatchQueue.global(qos: .background)
    let mainThread = DispatchQueue.main
    let activityIndicator = ActivityIndicator()
    
    private func setColors() {
        self.view.backgroundColor = UIColor.themeColor1
    }
    
    private func setupCompiledIngredientsList() {
        self.compiledIngredientsList = CompiledIngredientsList(frame: CGRect(x: 0, y: 0,
                                                                             width: self.view.frame.width,
                                                                             height: self.view.frame.height),
                                                               style: .plain)
    }
    
    private func addCompiledIngredientsList() {
        guard let compiledIngredientsList = self.compiledIngredientsList else { return }
        self.view.addSubview(compiledIngredientsList)
        guard let finishedShoppingButton = self.finishedShoppingBtn else { return }
        
        self.compiledIngredientsList?.translatesAutoresizingMaskIntoConstraints = false
        self.compiledIngredientsList?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5).isActive = true
        self.compiledIngredientsList?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        self.compiledIngredientsList?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5).isActive = true
        self.compiledIngredientsList?.bottomAnchor.constraint(equalTo: finishedShoppingButton.topAnchor, constant: -5).isActive = true
    }
    
    private func calculateIngredients() {
        // aggregate all ingredients from selected recipes
        if let selectedMenuOptions = self.menuOptionsObj?.selectedMenuOptions {
            for menuOption in selectedMenuOptions {
                if let recipeIngredients = menuOption.recipe?.ingredients {
                    self.compiledIngredients += recipeIngredients
                }
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
        
    }
    
    private func injectCompiledIngredientsList() {
        self.compiledIngredientsList?.compiledIngredients = self.reducedCompiledIngredients
        self.compiledIngredientsList?.reloadData()
    }
    
    private func setupFinishedShoppingBtn() {
        self.finishedShoppingBtn = NextStepBtn(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), setTitle: "Finished Shopping!")
        self.finishedShoppingBtn?.addTarget(self, action: #selector(finishedShoppingAction), for: .touchUpInside)
        self.finishedShoppingBtn?.layer.cornerRadius = 5
    }
    
    private func addFinishedShoppingBtn() {
        guard let finishedShoppingButton = self.finishedShoppingBtn else { return }
        self.view.addSubview(finishedShoppingButton)
        
        finishedShoppingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            finishedShoppingButton.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
            finishedShoppingButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            finishedShoppingButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            finishedShoppingButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5)
        ])
    }
    
    private func downloadRecipeImages() {
        guard let selectedMenuOptions = self.menuOptionsObj?.selectedMenuOptions else { return }
        
        self.mainThread.async {
            self.activityIndicator.activityInProgress()
        }
        
        for menuOption in selectedMenuOptions {
            let dispatchWorkItem = DispatchWorkItem {
                if let imageURL = menuOption.recipe?.recipeImageLink {
                    ImageAPI.shared.downloadImage(urlLink: imageURL, completion: {
                        menuOption.recipe?.recipeImage = UIImage(data: $0)
                        self.dispatchGroup.leave()
                    })
                }
            }
            self.dispatchGroup.enter()
            self.backgroundThread.async(group: self.dispatchGroup, execute: dispatchWorkItem)
        }
    }
    
    @objc private func finishedShoppingAction() {
        let mealPrepViewController = MealPrepViewController()
        
        self.downloadRecipeImages()
        
        self.dispatchGroup.notify(queue: self.mainThread) {
            self.activityIndicator.activityEnded()
            mealPrepViewController.menuOptionsObj = self.menuOptionsObj
            self.present(mealPrepViewController, animated: true, completion: nil)
        }
    }

}
