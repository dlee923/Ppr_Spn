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
    
    // MARK:  Variables
    var brandView: BrandType?
    var brand: Brand?
    var menuOptionList: MenuOptionList!
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
    var menuOptionListCollapsedConstant: CGFloat? {
        didSet {
            self.menuOptionListCollapsed = self.menuOptionList?.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: menuOptionListCollapsedConstant ?? 0.0)
        }
    }
    var menuOptionListExpandedConstant: CGFloat? {
        didSet {
            self.menuOptionListExpanded = self.menuOptionList?.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -(self.menuOptionListExpandedConstant ?? 0.0) - 5)
        }
    }
    
    private func setupMenuOptionsList() {
        self.menuOptionList = MenuOptionList(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.menuOptionList.menuOptionsObj = self.menuOptionsObj
        self.menuOptionList.brandView = self.brandView
        self.menuOptionList.brand = self.brand
        self.menuOptionList.brandDashboardControllerDelegate = self.brandDashboardControllerDelegate
        self.menuOptionList.parentViewControllerDelegate = self.parentViewControllerDelegate
    }
    
    private func addViewMenuOptionList(){
        self.view.addSubview(self.menuOptionList)
        
        self.menuOptionList?.translatesAutoresizingMaskIntoConstraints = false
        self.menuOptionList?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        self.menuOptionList?.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5).isActive = true
        self.menuOptionList?.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        
        self.menuOptionListCollapsed = self.menuOptionList?.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: menuOptionListCollapsedConstant ?? 0.0)
        
//        if let menuOptionListExpandedConstant = self.menuOptionListExpandedConstant {
//            self.menuOptionListExpanded = self.menuOptionList?.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -menuOptionListExpandedConstant - 5)
//        }
        
        self.menuOptionListCollapsed?.isActive = true
    }
    
    func scrollMenuOptionList(){
        if self.menuOptionListCollapsed?.isActive == true {
            
        }
    }

}


