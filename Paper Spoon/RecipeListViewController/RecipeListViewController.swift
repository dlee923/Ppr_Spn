//
//  RecipeListViewController.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/4/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class RecipeListViewController: UIViewController {

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
    
    var menuOptionList: MenuOptionList!
    var compileIngredientsBtn: NextStepBtn?
    var menuOptionsObj = MenuOptionObj(menuOptions: nil)
    
    private func setColors() {
        self.view.backgroundColor = UIColor.themeColor1
    }
    
    private func setupMenuOptionsList() {
        self.menuOptionList = MenuOptionList(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.menuOptionList.menuOptionsObj = self.menuOptionsObj
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
        self.compileIngredientsBtn?.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1).isActive = true
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
        self.present(compiledIngredientsViewController, animated: true, completion: nil)
    }

}

