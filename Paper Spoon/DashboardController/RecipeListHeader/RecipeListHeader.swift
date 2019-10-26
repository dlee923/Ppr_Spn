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
        self.addClearSelectionOption()
        self.addHeaderLabel()
        self.addBrandsSelectorArrow()
    }
    
    let brandsSelectorArrow = BrandsSelectorView()
    lazy var brandsPickerView = BrandsCollectionView(frame: self.frame, collectionViewLayout: UICollectionViewFlowLayout())
    let headerLabel = UILabel()
    var clearSelectionView = UIStackView()
    
    var brands: [Brand]? {
        didSet {
            self.brandsPickerView.brands = self.brands
        }
    }
    
    var brandsSelectorLeadingConstraint: NSLayoutConstraint?
    
    private func addHeaderLabel() {
        self.headerLabel.backgroundColor = .yellow
        self.headerLabel.font = UIFont.fontSunflower?.withSize(30)
        self.headerLabel.text = "Choose Recipes:"
        self.addSubview(self.headerLabel)
        
        self.headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.headerLabel.topAnchor.constraint(equalTo: self.brandsPickerView.bottomAnchor),
            self.headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.headerLabel.trailingAnchor.constraint(equalTo: self.clearSelectionView.leadingAnchor, constant: -5),
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
    
    private func addBrandsSelectorArrow() {
        self.addSubview(self.brandsSelectorArrow)
        self.brandsSelectorArrow.translatesAutoresizingMaskIntoConstraints = false
        self.brandsSelectorLeadingConstraint = self.brandsSelectorArrow.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
        guard let brandsSelectorLeadingConstraint = self.brandsSelectorLeadingConstraint else { return }
        NSLayoutConstraint.activate([
            self.brandsSelectorArrow.heightAnchor.constraint(equalToConstant: 7),
            self.brandsSelectorArrow.centerYAnchor.constraint(equalTo: self.topAnchor),
            self.brandsSelectorArrow.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4),
            brandsSelectorLeadingConstraint
        ])
    }
    
    private func addClearSelectionOption() {
        self.addSubview(self.clearSelectionView)
        self.clearSelectionView.backgroundColor = .black
        self.clearSelectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.clearSelectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.clearSelectionView.topAnchor.constraint(equalTo: self.brandsPickerView.bottomAnchor),
            self.clearSelectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.clearSelectionView.widthAnchor.constraint(equalToConstant: 75)
        ])
        
        let clearSelectionText = UILabel()
        clearSelectionText.text = "Clear All"
        clearSelectionText.textAlignment = .right
        clearSelectionText.font = UIFont.fontCoolvetica?.withSize(10)
        clearSelectionText.textColor = UIColor.themeColor2
        
        let clearSelectionImage = UIImageView()
        clearSelectionImage.image = UIImage(named: "cancel_x")
        clearSelectionImage.contentMode = .scaleAspectFit
        clearSelectionImage.translatesAutoresizingMaskIntoConstraints = false
        clearSelectionImage.widthAnchor.constraint(equalToConstant: 10).isActive = true
        
        self.clearSelectionView.addArrangedSubview(clearSelectionText)
        self.clearSelectionView.addArrangedSubview(clearSelectionImage)
        
        self.clearSelectionView.stackProperties(axis: .horizontal, spacing: 5, alignment: .fill, distribution: .fillProportionally)
        
        // By default - set as hidden
        self.clearSelectionView.isHidden = true
    }
    
    func moveBrandsSelectorView(index: Int) {
        let indexLength = self.frame.width / 4
        self.brandsSelectorLeadingConstraint?.constant = indexLength * CGFloat(index)
    }
    
    func changeRecipeListHeader(numberOfRecipesSelected: Int, maxRecipes: Int) {
        self.headerLabel.text = numberOfRecipesSelected > 0 ? "\(numberOfRecipesSelected) / \(maxRecipes) Selected" : "Choose Recipes:"
        self.clearSelectionView.isHidden = numberOfRecipesSelected > 0 ? false : true
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
