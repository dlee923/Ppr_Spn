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
    
    
    override func viewDidAppear(_ animated: Bool) {
        for cell in self.mealsPrepCollectionView.visibleCells {
            if let mealsPrepCollectionViewCell = cell as? MealsPrepCollectionViewCell {
                mealsPrepCollectionViewCell.mealPreppedBtnView?.compileIngredientsBtn?.startPulseAnimation()
            }
        }
    }
    
    
    private func setup() {
        self.setColors()
        self.setupMealsToPrep()
        self.addMealsToPrep()
        
//        self.setupMealsPrepCount()
//        self.addMealsPrepCount()
    }
    
    
    // MARK:  Data Variables
    var menuOptionsObj: MenuOptionObj?
    
    // MARK:  UI Elements
    var mealsPrepCount = UIPageControl()
    var mealsPrepCollectionView = MealsPrepCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var mealPrepFinishedBtn = UIButton()
    
    // MARK:  Delegates
    var parentViewControllerDelegate: ParentViewControllerDelegate?
    
    let activityIndicator = ActivityIndicator()
    
    private func setColors() {
        self.view.backgroundColor = UIColor.themeColor1
        self.mealsPrepCount.backgroundColor = UIColor.color6
    }

    private func setupMealsToPrep() {
        self.mealsPrepCollectionView.frame = self.view.frame
        self.mealsPrepCollectionView.menuOptionsObj = self.menuOptionsObj
        self.mealsPrepCollectionView.mealPrepFinishedDelegate = self
        self.mealsPrepCollectionView.parentViewControllerDelegate = self.parentViewControllerDelegate
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

extension MealPrepViewController: MealPrepFinishedDelegate {
    
    func addToPreppedMeals(menuOption: MenuOption) {
        // add menuOption to kittedMenuOptions and remove menuOption from selectedMenuOptions
        self.menuOptionsObj?.menuOptionKittedComplete(for: menuOption)
        
        // reload meal kits prep view controller
        self.parentViewControllerDelegate?.reloadMealPrep()
        
        // simply reload the meal kits selection view controller
        self.parentViewControllerDelegate?.reloadMealKitSelection()
    }
    
}

protocol MealPrepFinishedDelegate: AnyObject {
    func addToPreppedMeals(menuOption: MenuOption)
}
