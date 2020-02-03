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
        self.view.backgroundColor = UIColor.themeColor1
        self.instructionsView.mealKitSelectionViewControllerDelegate = self
    }
    
    var menuOptionsObj: MenuOptionObj?
    var instructionsView = InstructionsViewController()
    
    var mealKitsCollectionView = MealKitsCollectionView(frame: .zero)
    
    // MARK:  Delegates
    var parentViewControllerDelegate: ParentViewControllerDelegate?
    var favCollectionViewControllerDelegate: FavCollectionViewControllerDelegate?
    
    private func addMealKitsCollectionView() {
        self.mealKitsCollectionView.frame = self.view.frame
        self.mealKitsCollectionView.menuOptionsObj = self.menuOptionsObj
        self.mealKitsCollectionView.mealKitSelectionViewControllerDelegate = self
        self.mealKitsCollectionView.parentViewControllerDelegate = self.parentViewControllerDelegate
        self.mealKitsCollectionView.favCollectionViewControllerDelegate = self.favCollectionViewControllerDelegate
        
        self.view.addSubview(self.mealKitsCollectionView)
        self.mealKitsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.mealKitsCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.mealKitsCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.mealKitsCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            self.mealKitsCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
}

protocol MealKitSelectionViewControllerDelegate: AnyObject {
    func presentInstructions(menuOption: MenuOption)
    func lockScrollView()
    func unlockScrollView()
}

extension MealKitSelectionViewController: MealKitSelectionViewControllerDelegate {
    func presentInstructions(menuOption: MenuOption) {
        self.instructionsView.menuOption = menuOption
        self.instructionsView.modalPresentationStyle = .pageSheet
        self.present(self.instructionsView, animated: true, completion: nil)
    }
    
    func lockScrollView() {
        self.mealKitsCollectionView.isScrollEnabled = false
    }
    
    func unlockScrollView() {
        self.mealKitsCollectionView.isScrollEnabled = true
    }
}
