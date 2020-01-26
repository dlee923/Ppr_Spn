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
        // Do any additional setup after loading the view.
        
        // add menu option list to view
        self.setupMenuOptionsList()
        self.addViewMenuOptionList()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // reset scroll to top
        self.menuOptionList.setContentOffset(CGPoint(x: 0, y: -self.menuOptionList.contentInsetValue - 44 + 10), animated: true)
        // reset fadeOut to false
        self.parentViewControllerDelegate?.setFadeOut(fadeOut: false)
        self.parentViewControllerDelegate?.fadeTabBar(fadePct: 1.0)
    }
    
    
    // MARK:  Variables
    var brandView: BrandType?
    var brand: Brand?
    var menuOptionList = MenuOptionList(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var menuOptionsObj: MenuOptionObj?
    
    let dispatchGroup = DispatchGroup()
    let mainThread = DispatchQueue.main
    let backgroundThread = DispatchQueue.global(qos: .background)
    
    // MARK:  Delegates
    var brandDashboardControllerDelegate: BrandDashboardControllerDelegate?
    var parentViewControllerDelegate: ParentViewControllerDelegate?
    
    // MARK:  Animatable constraints
    var menuOptionListCollapsed: NSLayoutConstraint?
    var menuOptionListExpanded: NSLayoutConstraint?
    
    private func setupMenuOptionsList() {
        self.menuOptionList.frame = self.view.frame
        self.menuOptionList.menuOptionsObj = self.menuOptionsObj
        self.menuOptionList.brandView = self.brandView
        self.menuOptionList.brand = self.brand
        self.menuOptionList.brandDashboardControllerDelegate = self.brandDashboardControllerDelegate
        self.menuOptionList.parentViewControllerDelegate = self.parentViewControllerDelegate
    }
    
    private func addViewMenuOptionList(){
        self.view.addSubview(self.menuOptionList)
        
        self.menuOptionList.translatesAutoresizingMaskIntoConstraints = false
        self.menuOptionList.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.menuOptionList.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5).isActive = true
        self.menuOptionList.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        
        self.menuOptionListCollapsed = self.menuOptionList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -35)
        
        self.menuOptionListCollapsed?.isActive = true
        
        // set up additional menuOptionListExpand/Collapse
        self.menuOptionListExpanded = self.menuOptionList.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
    }
    

}


