//
//  CompileIngredientsViewController.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/17/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class CompiledIngredientsViewController: UIViewController {

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
    }
    
    // MARK:  Variables
    var menuOptionsObj: MenuOptionObj?
    var reducedCompiledIngredients = [Ingredients]()
    
    // MARK:  UI Elements
    var compiledIngredientsList: CompiledIngredientsList?
    let activityIndicator = ActivityIndicator()
    var finishedShoppingBtn: NextStepBtn?
    
    // MARK:  Threading
    let dispatchGroup = DispatchGroup()
    let backgroundThread = DispatchQueue.global(qos: .background)
    let mainThread = DispatchQueue.main
    
    // MARK:  Delegates
    var parentViewControllerDelegate: ParentViewControllerDelegate?
    
    private func setColors() {
        self.view.backgroundColor = UIColor.themeColor1
    }
    
    private func setupCompiledIngredientsList() {
        self.compiledIngredientsList = CompiledIngredientsList(frame: CGRect(x: 0, y: 0,
                                                                             width: self.view.frame.width,
                                                                             height: self.view.frame.height),
                                                               style: .plain)
        self.compiledIngredientsList?.compiledIngredients = self.reducedCompiledIngredients
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
