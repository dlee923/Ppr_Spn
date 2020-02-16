//
//  SelectedMenuOptionView.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 2/9/20.
//  Copyright © 2020 DLEE. All rights reserved.
//

import UIKit

class SelectedMenuOptionView: UIView {
    
    convenience init(frame: CGRect, selectedMenuOptions: [MenuOption]) {
        self.init(frame: frame)
        self.selectedMenuOptionList.selectedMenuOptions = selectedMenuOptions
        self.selectedMenuOptionList.reloadData()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSelectedMenuOptionList()
        self.addSelectNewMeals()
    }
    
    // MARK: Variables
    var selectedMenuOptionList = SelectedMenuOptionList(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var selectNewMealsBtn = UIButton()
    var contentInsetValue: CGFloat = 100
    
    // MARK: Delegates
    var brandDashboardControllerDelegate: BrandDashboardControllerDelegate?
    
    private func addSelectedMenuOptionList() {
        self.addSubview(selectedMenuOptionList)
        self.selectedMenuOptionList.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.selectedMenuOptionList.topAnchor.constraint(equalTo: self.topAnchor, constant: self.contentInsetValue - 10),
            self.selectedMenuOptionList.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.selectedMenuOptionList.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
            self.selectedMenuOptionList.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5)
        ])
    }
    
    private func addSelectNewMeals() {
        self.selectNewMealsBtn.setTitle("Select Different Meals", for: .normal)
        self.selectNewMealsBtn.titleLabel?.font = UIFont.fontSunflower?.withSize(20)
        self.selectNewMealsBtn.layer.cornerRadius = 5
        self.selectNewMealsBtn.backgroundColor = UIColor.themeColor4
        self.addSubview(self.selectNewMealsBtn)
        self.selectNewMealsBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.selectNewMealsBtn.topAnchor.constraint(equalTo: self.selectedMenuOptionList.bottomAnchor),
            self.selectNewMealsBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.selectNewMealsBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.selectNewMealsBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.selectNewMealsBtn.addTarget(self, action: #selector(self.resetMealSelection), for: .touchUpInside)
    }
    
    @objc func resetMealSelection() {
        print("resetting meal selections")
        self.brandDashboardControllerDelegate?.clearSelections()
        self.brandDashboardControllerDelegate?.resetSelections()
        self.removeSelectedMenuOptionView()
    }
    
    private func removeSelectedMenuOptionView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }) { (completed) in
            self.removeFromSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
