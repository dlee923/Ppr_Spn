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
        self.addSelectNewMealsBtnView()

        self.addSelectedMenuOptionList()
        self.backgroundColor = UIColor.themeColor1
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }
    
    // MARK: Variables
    var selectedMenuOptionList = SelectedMenuOptionList(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//    var selectNewMealsBtn = UIButton()
    let selectNewMealsBtnView = NextStepBtnView()
    var contentInsetValue: CGFloat = 20
    
    // MARK: Delegates
    var brandDashboardControllerDelegate: BrandDashboardControllerDelegate?
    
    private func addSelectNewMealsBtnView() {
        self.selectNewMealsBtnView.backgroundColor = UIColor.themeColor1
        self.addSubview(self.selectNewMealsBtnView)
        
        self.selectNewMealsBtnView.translatesAutoresizingMaskIntoConstraints = false
        
        let headerSize = self.frame.height * 0.2
        let menuOptionListInset = self.contentInsetValue - 10
        let statusBar: CGFloat = 25
        
        NSLayoutConstraint.activate([
            self.selectNewMealsBtnView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06),
            self.selectNewMealsBtnView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.selectNewMealsBtnView.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.selectNewMealsBtnView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
        ])
        
        self.selectNewMealsBtnView.compileIngredientsBtn?.setTitle("Select Different Meals", for: .normal)
        self.selectNewMealsBtnView.compileIngredientsBtn?.addTarget(self, action: #selector(self.resetMealSelection), for: .touchUpInside)
        self.selectNewMealsBtnView.finger.removeFromSuperview()
        self.selectNewMealsBtnView.compileIngredientsBtn?.startPulseAnimation()
    }
    
//    private func addSelectNewMealsBtn() {
//        self.selectNewMealsBtn.setTitle("Select Different Meals", for: .normal)
//        self.selectNewMealsBtn.titleLabel?.font = UIFont.fontSunflower?.withSize(12)
//        self.selectNewMealsBtn.layer.cornerRadius = 5
//        self.selectNewMealsBtn.backgroundColor = UIColor.themeColor4
//        self.selectNewMealsBtnView.addSubview(self.selectNewMealsBtn)
//
//        self.selectNewMealsBtn.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            self.selectNewMealsBtn.heightAnchor.constraint(equalTo: self.selectNewMealsBtnView.heightAnchor, multiplier: 0.85),
//            self.selectNewMealsBtn.centerXAnchor.constraint(equalTo: self.selectNewMealsBtnView.centerXAnchor),
//            self.selectNewMealsBtn.widthAnchor.constraint(equalTo: self.selectNewMealsBtnView.widthAnchor, multiplier: 0.5),
//            self.selectNewMealsBtn.centerYAnchor.constraint(equalTo: self.selectNewMealsBtnView.centerYAnchor)
//        ])
//
//        self.selectNewMealsBtn.addTarget(self, action: #selector(self.resetMealSelection), for: .touchUpInside)
//    }
    
    private func addSelectedMenuOptionList() {
        self.addSubview(selectedMenuOptionList)
        
        self.selectedMenuOptionList.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.selectedMenuOptionList.topAnchor.constraint(equalTo: self.selectNewMealsBtnView.bottomAnchor),
            self.selectedMenuOptionList.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.selectedMenuOptionList.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.selectedMenuOptionList.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5)
        ])
    }
    
    @objc func resetMealSelection() {
        print("resetting meal selections")
        self.brandDashboardControllerDelegate?.clearSelections()
        self.brandDashboardControllerDelegate?.resetSelections()
        self.brandDashboardControllerDelegate?.lockUnlockScrollView()
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
