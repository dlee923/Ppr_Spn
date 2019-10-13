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
        self.addHeaderLabel()
        self.addBrandPickerView()
    }
    
    let headerLabel = UILabel()
    lazy var brandsPickerView = BrandsCollectionView(frame: self.frame, collectionViewLayout: UICollectionViewFlowLayout())
    var brands: [Brand]? {
        didSet {
            self.brandsPickerView.brands = self.brands
        }
    }
    
    private func addHeaderLabel() {
        self.headerLabel.font = UIFont.fontSunflower?.withSize(30)
        self.headerLabel.text = "Choose Recipes:"
        self.addSubview(self.headerLabel)
        
        self.headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.headerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.headerLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            ])
    }
    
    private func addBrandPickerView() {
        self.addSubview(self.brandsPickerView)
        self.brandsPickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.brandsPickerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.brandsPickerView.heightAnchor.constraint(equalToConstant: 30),
            self.brandsPickerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.brandsPickerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
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
