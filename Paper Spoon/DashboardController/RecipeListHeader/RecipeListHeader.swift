//
//  RecipeListHeader.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 9/14/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class RecipeListHeader: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    private func setup() {
        self.addBrandPickerView()
        self.addHeaderLabel()
        self.addBrandsSelectorView()
    }
    
    let headerLabel = UILabel()
    lazy var brandsPickerView = BrandsCollectionView(frame: self.frame, collectionViewLayout: UICollectionViewFlowLayout())
    let brandsSelectorView = BrandsSelectorView()
    
    var brands: [Brand]? {
        didSet {
            self.brandsPickerView.brands = self.brands
        }
    }
    
    var brandsSelectorLeadingConstraint: NSLayoutConstraint?
    
    private func addHeaderLabel() {
        self.headerLabel.font = UIFont.fontSunflower?.withSize(30)
        self.headerLabel.text = "Choose Recipes:"
        self.addSubview(self.headerLabel)
        
        self.headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.headerLabel.topAnchor.constraint(equalTo: self.brandsPickerView.bottomAnchor),
            self.headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
    }
    
    private func addBrandPickerView() {
        self.addSubview(self.brandsPickerView)
        self.brandsPickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.brandsPickerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.brandsPickerView.heightAnchor.constraint(equalToConstant: 40),
            self.brandsPickerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.brandsPickerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func addBrandsSelectorView() {
        self.addSubview(self.brandsSelectorView)
        self.brandsSelectorView.translatesAutoresizingMaskIntoConstraints = false
        self.brandsSelectorLeadingConstraint = self.brandsSelectorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
        guard let brandsSelectorLeadingConstraint = self.brandsSelectorLeadingConstraint else { return }
        NSLayoutConstraint.activate([
            self.brandsSelectorView.heightAnchor.constraint(equalToConstant: 7),
            self.brandsSelectorView.centerYAnchor.constraint(equalTo: self.topAnchor),
            self.brandsSelectorView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4),
            brandsSelectorLeadingConstraint
        ])
    }
    
    func moveBrandsSelectorView(index: Int) {
        let indexLength = self.frame.width / 4
        self.brandsSelectorLeadingConstraint?.constant = indexLength * CGFloat(index)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
}


struct Brand {
    var name: BrandType
    var image: UIImage
}

enum BrandType {
    case HelloFresh
    case BlueApron
    case HomeChef
    case EveryPlate
    case Plated
    case PurpleCarrot
}
