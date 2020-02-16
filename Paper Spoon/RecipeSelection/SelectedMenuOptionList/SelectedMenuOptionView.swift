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
        self.backgroundColor = UIColor.themeColor1
        self.selectedMenuOptionList.selectedMenuOptions = selectedMenuOptions
        self.selectedMenuOptionList.reloadData()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSelectedMenuOptionList()
    }
    
    var selectedMenuOptionList = SelectedMenuOptionList(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var selectNewMealsBtn = UIButton()
    
    private func addSelectedMenuOptionList() {
        self.addSubview(selectedMenuOptionList)
        self.selectedMenuOptionList.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.selectedMenuOptionList.topAnchor.constraint(equalTo: self.topAnchor),
            self.selectedMenuOptionList.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.selectedMenuOptionList.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
            self.selectedMenuOptionList.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    private func addSelectNewMeals() {
        self.selectNewMealsBtn.setTitle("Select Different Meals", for: .normal)
        self.selectNewMealsBtn.layer.cornerRadius = 5
        self.selectNewMealsBtn.backgroundColor = UIColor.themeColor4
        self.addSubview(self.selectNewMealsBtn)
        self.selectNewMealsBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.selectNewMealsBtn.topAnchor.constraint(equalTo: self.selectedMenuOptionList.topAnchor),
            self.selectNewMealsBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.selectNewMealsBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.selectNewMealsBtn.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
