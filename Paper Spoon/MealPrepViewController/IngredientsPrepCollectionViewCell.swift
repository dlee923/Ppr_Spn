//
//  IngredientsPrepTableViewCell.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 9/12/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class IngredientsPrepCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    
    var ingredient: Ingredients? {
        didSet {
            self.label.text = self.ingredient?.name
            
            if let ingredientAmount = self.ingredient?.amount, let ingredientMeasure = self.ingredient?.measurementType {
                self.measureAmountLbl.text = "\(ingredientAmount) \(ingredientMeasure)"
            }
            
            // enable visibility of 'packed' label
            self.checkMarkView.isHidden = self.ingredient?.isPacked == true ? false : true
        }
    }
    
    let label = UILabel()
    let checkMarkView = UILabel()
    let measureAmountLbl = UILabel()
    let ingredientImg = UIImageView()
    
    private func setup() {
        self.backgroundColor = .yellow
        self.addLabel()
        self.addIngredientImage()
        self.addMeasureAmount()
        self.addCheckMarkView()
    }
    
    private func addIngredientImage() {
        self.addSubview(self.ingredientImg)
        self.ingredientImg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.ingredientImg.bottomAnchor.constraint(equalTo: self.label.topAnchor),
            self.ingredientImg.topAnchor.constraint(equalTo: self.topAnchor),
            self.ingredientImg.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.ingredientImg.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
        ])
    }
    
    private func addMeasureAmount() {
        self.measureAmountLbl.font = UIFont.fontSunflower?.withSize(25)
        self.addSubview(self.measureAmountLbl)
        self.measureAmountLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.measureAmountLbl.leadingAnchor.constraint(equalTo: self.ingredientImg.trailingAnchor, constant: 5),
            self.measureAmountLbl.topAnchor.constraint(equalTo: self.topAnchor),
            self.measureAmountLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.measureAmountLbl.bottomAnchor.constraint(equalTo: self.label.topAnchor)
        ])
    }
    
    private func addLabel() {
        self.label.font = UIFont.fontCoolvetica?.withSize(10)
        self.addSubview(self.label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.label.heightAnchor.constraint(equalToConstant: 15),
            self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
    
    private func addCheckMarkView() {
        self.checkMarkView.font = UIFont.fontCoolvetica?.withSize(15)
        self.checkMarkView.isHidden = true
        self.checkMarkView.backgroundColor = UIColor.black
        self.checkMarkView.alpha = 0.7
        self.checkMarkView.textColor = .white
        self.checkMarkView.text = "Ingredient Packed!"
        self.checkMarkView.textAlignment = .center
        self.checkMarkView.layer.cornerRadius = 5
        self.checkMarkView.clipsToBounds = true
        self.addSubview(self.checkMarkView)
        
        self.checkMarkView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.checkMarkView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.checkMarkView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.checkMarkView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.checkMarkView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
            ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.checkMarkView.isHidden = self.ingredient?.isPacked == true ? false : true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
}
