//
//  MealKitSelectionViewController.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/31/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class MealKitSelectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.addMealKitsCollectionView()
    }
    
    private func setup() {
        self.view.backgroundColor = UIColor.color4
    }
    
    var menuOptionsObj: MenuOptionObj?
    
    lazy var mealKitsCollectionView = MealKitsCollectionView(frame: self.view.frame)
    
    private func addMealKitsCollectionView() {
        self.mealKitsCollectionView.menuOptionsObj = self.menuOptionsObj
        
        self.view.addSubview(self.mealKitsCollectionView)
        self.mealKitsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.mealKitsCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            self.mealKitsCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
            self.mealKitsCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.mealKitsCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    
    
}
