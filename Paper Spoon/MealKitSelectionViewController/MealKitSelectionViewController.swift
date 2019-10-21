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
    }
    
    var menuOptionsObj: MenuOptionObj?
    var instructionsView = InstructionsViewController()
    
    lazy var mealKitsCollectionView = MealKitsCollectionView(frame: self.view.frame)
    
    private func addMealKitsCollectionView() {
        self.mealKitsCollectionView.menuOptionsObj = self.menuOptionsObj
        self.mealKitsCollectionView.mealKitSelectionViewControllerDelegate = self
        
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
}

extension MealKitSelectionViewController: MealKitSelectionViewControllerDelegate {
    func presentInstructions(menuOption: MenuOption) {
        self.instructionsView.menuOption = menuOption
        self.instructionsView.modalPresentationStyle = .pageSheet
        self.present(self.instructionsView, animated: true, completion: nil)
    }
}
