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
    
    private func setup() {
        self.setColors()
        self.setupCompiledIngredientsList()
        self.addCompiledIngredientsList()
    }
    
    // MARK:  Variables
    var menuOptionsObj: MenuOptionObj?
    var reducedCompiledIngredients = [Ingredients]() {
        didSet {
            self.compiledIngredientsList.compiledIngredients = self.reducedCompiledIngredients
        }
    }
    
    // MARK:  UI Elements
    var compiledIngredientsList = CompiledIngredientsList()
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
        self.compiledIngredientsList.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.compiledIngredientsList.parentViewControllerDelegate = self.parentViewControllerDelegate
    }
    
    private func addCompiledIngredientsList() {
        self.view.addSubview(compiledIngredientsList)
        self.compiledIngredientsList.translatesAutoresizingMaskIntoConstraints = false
        
        self.compiledIngredientsList.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5).isActive = true
        self.compiledIngredientsList.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        self.compiledIngredientsList.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5).isActive = true
        self.compiledIngredientsList.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    @objc private func finishedShoppingAction() {
        self.dispatchGroup.notify(queue: self.mainThread) {
            self.parentViewControllerDelegate?.changeViewController(index: 2)
        }
    }

}
