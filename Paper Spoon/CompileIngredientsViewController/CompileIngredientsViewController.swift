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
    
    private func setup() {
        self.view.backgroundColor = .gray
        self.setupCompiledIngredientsList()
        self.addCompiledIngredientsList()
    }
    
    var compiledIngredientsList: CompiledIngredientsList?
    
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

}
