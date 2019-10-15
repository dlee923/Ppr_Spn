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
        
        // add menu option list to view
        self.setupMenuOptionsList()
        self.addViewMenuOptionList()
    }
    
    private func setup() {
        self.setColors()
    }
    
    
    // MARK:  Variables
    var menuOptionList: MenuOptionList!
    var menuOptionsObj: MenuOptionObj?
    
    let dispatchGroup = DispatchGroup()
    let mainThread = DispatchQueue.main
    let backgroundThread = DispatchQueue.global(qos: .background)
    
    // MARK:  Delegates
    var brandDashboardControllerDelegate: BrandDashboardControllerDelegate?
    
    private func setColors() {
        self.view.backgroundColor = UIColor.themeColor1
    }
    
    private func setupMenuOptionsList() {
        self.menuOptionList = MenuOptionList(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.menuOptionList.menuOptionsObj = self.menuOptionsObj
        self.menuOptionList.brandDashboardControllerDelegate = self.brandDashboardControllerDelegate
    }
    
    private func addViewMenuOptionList(){
        self.view.addSubview(self.menuOptionList)
        
        self.menuOptionList?.translatesAutoresizingMaskIntoConstraints = false
        self.menuOptionList?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        self.menuOptionList?.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5).isActive = true
        self.menuOptionList?.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        self.menuOptionList?.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
    }

}


