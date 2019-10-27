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

//        self.setupFinishedShoppingBtn()
//        self.addFinishedShoppingBtn()
        
        self.setupCompiledIngredientsList()
        self.addCompiledIngredientsList()
    }
    
    // MARK:  Variables
    var menuOptionsObj: MenuOptionObj?
    var reducedCompiledIngredients = [Ingredients]() {
        didSet {
            self.compiledIngredientsList?.compiledIngredients = self.reducedCompiledIngredients
        }
    }
    
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
    }
    
    private func addCompiledIngredientsList() {
        guard let compiledIngredientsList = self.compiledIngredientsList else { return }
        self.view.addSubview(compiledIngredientsList)
        self.compiledIngredientsList?.translatesAutoresizingMaskIntoConstraints = false
        
        self.compiledIngredientsList?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5).isActive = true
        self.compiledIngredientsList?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        self.compiledIngredientsList?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5).isActive = true
        self.compiledIngredientsList?.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
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
    
    @objc private func finishedShoppingAction() {
        self.dispatchGroup.notify(queue: self.mainThread) {
            self.parentViewControllerDelegate?.changeViewController(index: 2)
        }
    }

}
