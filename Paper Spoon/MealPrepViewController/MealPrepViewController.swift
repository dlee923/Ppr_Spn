//
//  MealPrepViewController.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/24/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class MealPrepViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setup()
    }
    
    private func setup() {
        self.view.backgroundColor = .red
        self.setupMealsToPrep()
        self.addMealsToPrep()
        self.setupMealsPrepCount()
        self.addMealsPrepCount()
    }
    
    var menuOptionsObj: MenuOptionObj?
    var mealsPrepCount = UIPageControl()
    lazy var mealsPrepCollectionView = MealsPrepCollectionView(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout())

    private func setupMealsToPrep() {
        self.mealsPrepCollectionView.menuOptionsObj = self.menuOptionsObj
    }
    
    private func addMealsToPrep() {
        self.view.addSubview(self.mealsPrepCollectionView)
        
        self.mealsPrepCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.mealsPrepCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.mealsPrepCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.mealsPrepCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.mealsPrepCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
    }
    
    private func setupMealsPrepCount() {
        self.mealsPrepCount.numberOfPages = self.menuOptionsObj?.selectedMenuOptions.count ?? 0
        self.mealsPrepCount.backgroundColor = UIColor.color6
    }
    
    private func addMealsPrepCount() {
        self.mealsPrepCollectionView.addSubview(self.mealsPrepCount)
        self.mealsPrepCount.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.mealsPrepCount.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.mealsPrepCount.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.mealsPrepCount.heightAnchor.constraint(equalToConstant: 20),
            self.mealsPrepCount.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
    }

}
