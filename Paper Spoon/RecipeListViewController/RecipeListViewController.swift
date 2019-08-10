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
        
        // add menu option list to view
        self.setupMenuOptionsList()
        self.addViewMenuOptionList()
        
    }
    
    private func setup() {
        self.view.backgroundColor = .yellow
    }
    
    var menuOptionList: MenuOptionList!
    var menuOptionsObj = MenuOptionObj(menuOptions: nil)
    
    func setupMenuOptionsList() {
        self.menuOptionList = MenuOptionList(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.menuOptionList.menuOptionsObj = self.menuOptionsObj
    }
    
    func addViewMenuOptionList(){
        self.view.addSubview(self.menuOptionList)
        
        self.menuOptionList?.translatesAutoresizingMaskIntoConstraints = false
        self.menuOptionList?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.menuOptionList?.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.menuOptionList?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.menuOptionList?.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
    }

}
