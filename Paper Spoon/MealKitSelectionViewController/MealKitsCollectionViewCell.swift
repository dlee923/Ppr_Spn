//
//  MealKitsCollectionViewCell.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 9/2/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class MealKitsCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    var menuOption: MenuOption? {
        didSet {
            self.nameLabel.text = self.menuOption?.recipe?.name
            self.descriptionTextfield.text = self.menuOption?.recipe?.description
        }
    }
    
    let nameLabel = UILabel()
    let getCookingBtn = UIButton()
    let descriptionTextfield = UITextView()
    var scrollViewLockDelegate: ScrollViewLockDelegate?
    
    private func setup() {
        self.backgroundColor = UIColor.white
        self.addLabel()
        self.addGetCookingButton()
        self.addDescriptionTextfield()
    }
    
    private func addLabel() {
        self.nameLabel.textColor = .black
        self.addSubview(self.nameLabel)
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.nameLabel.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func addGetCookingButton() {
        self.getCookingBtn.setTitle("Get Cooking", for: .normal)
        self.getCookingBtn.titleLabel?.font = UIFont.fontSunflower?.withSize(20)
        self.getCookingBtn.backgroundColor = UIColor.color8
        
        self.addSubview(self.getCookingBtn)
        self.getCookingBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.getCookingBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.getCookingBtn.heightAnchor.constraint(equalToConstant: 35),
            self.getCookingBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.getCookingBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.getCookingBtn.addTarget(self, action: #selector(self.showInstructions), for: .touchUpInside)
    }
    
    private func addDescriptionTextfield() {
        self.descriptionTextfield.textColor = .blue
        self.descriptionTextfield.textAlignment = .left
        self.addSubview(self.descriptionTextfield)
        
        self.descriptionTextfield.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.descriptionTextfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.descriptionTextfield.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor),
            self.descriptionTextfield.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.descriptionTextfield.bottomAnchor.constraint(equalTo: self.getCookingBtn.topAnchor)
        ])
    }
    
    @objc private func showInstructions() {
        // lock parent scroll view to prevent scrolling to other recipes
        self.scrollViewLockDelegate?.lockScrollView()
        
        print("show instructions")
        let instructionsCollectionView = InstructionsCollectionView(frame: self.frame)
        instructionsCollectionView.recipe = self.menuOption?.recipe
        self.addSubview(instructionsCollectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
