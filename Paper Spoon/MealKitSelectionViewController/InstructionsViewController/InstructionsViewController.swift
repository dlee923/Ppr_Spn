//
//  InstructionsView.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 9/7/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.mealKitSelectionViewControllerDelegate?.unlockScrollView()
    }
    
    var instructionsCollectionView: InstructionsCollectionView?
    var finishedCookingBtn = UIButton()
    var menuOption: MenuOption? {
        didSet {
            self.instructionsCollectionView?.recipe = self.menuOption?.recipe
        }
    }
    
    var mealKitSelectionViewControllerDelegate: MealKitSelectionViewControllerDelegate?
    
    private func setup() {
        self.view.backgroundColor = UIColor.themeColor1
        self.addFinishedCookingBtn()
        self.addInstructionsCollectionView()
    }
    
    private func addFinishedCookingBtn() {
        self.finishedCookingBtn.setTitle("Finished Cooking!", for: .normal)
        self.finishedCookingBtn.titleLabel?.font = UIFont.fontSunflower?.withSize(20)
        self.finishedCookingBtn.backgroundColor = UIColor.color2
        self.finishedCookingBtn.layer.cornerRadius = 5
        self.view.addSubview(self.finishedCookingBtn)
        
        self.finishedCookingBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.finishedCookingBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            self.finishedCookingBtn.heightAnchor.constraint(equalToConstant: 60),
            self.finishedCookingBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
            self.finishedCookingBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.finishedCookingBtn.addTarget(self, action: #selector(self.dismissInstructions), for: .touchUpInside)
    }
    
    @objc private func dismissInstructions() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func addInstructionsCollectionView() {
        self.instructionsCollectionView = InstructionsCollectionView(frame: self.view.frame)
        self.instructionsCollectionView?.recipe = self.menuOption?.recipe
        guard let instructionsCV = self.instructionsCollectionView else { return }
        self.view.addSubview(instructionsCV)
        
        instructionsCV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            instructionsCV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            instructionsCV.topAnchor.constraint(equalTo: self.view.topAnchor),
            instructionsCV.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            instructionsCV.bottomAnchor.constraint(equalTo: self.finishedCookingBtn.topAnchor, constant: -5)
        ])
    }
    
}
