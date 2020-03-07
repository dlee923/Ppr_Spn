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
        self.addBlurView()
    }
    
    // MARK:  UI Elements
    let brandsSelectorArrow = BrandsSelectorView()
    lazy var brandsPickerView = BrandsCollectionView(frame: self.frame, collectionViewLayout: UICollectionViewFlowLayout())
    let headerLabel = UILabel()
    var clearSelectionView = UIStackView()
    let blurView = UIVisualEffectView()
    let blurEffect = UIBlurEffect(style: .extraLight)
    
    // MARK:  Data Variables
    var brands: [Brand]? {
        didSet {
            self.brandsPickerView.brands = self.brands
        }
    }
    
    // MARK:  Animatable Constraints
    var brandsSelectorLeadingConstraint: NSLayoutConstraint?
    
    // MARK:  Delegates
    var brandDashboardControllerDelegate: BrandDashboardControllerDelegate?
    
    private func addHeaderLabel() {
        self.headerLabel.font = UIFont.fontSunflower?.withSize(30)
        self.headerLabel.text = "Choose Recipes"
        self.headerLabel.textColor = UIColor.themeColor1
        self.headerLabel.addShadow(path: nil, color: UIColor.black, offset: CGSize(width: 4, height: 4), radius: 3.0, opacity: 1.0)
        
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
            self.brandsSelectorArrow.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
            brandsSelectorLeadingConstraint
        ])
    }
    
    private func addBlurView() {
        self.blurView.effect = self.blurEffect
        self.insertSubview(self.blurView, at: 0)
        self.blurView.alpha = 0
        self.blurView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.blurView.topAnchor.constraint(equalTo: self.topAnchor),
            self.blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.blurView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -5),
            self.blurView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5)
        ])
    }
    
    private func addClearSelectionOption() {
        self.addSubview(self.clearSelectionView)
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
        clearSelectionText.textColor = UIColor.themeColor4
        
        let clearSelectionImage = UIImageView()
        clearSelectionImage.image = UIImage(named: "cancel_x")?.withRenderingMode(.alwaysTemplate)
        clearSelectionImage.tintColor = UIColor.themeColor4
        clearSelectionImage.contentMode = .scaleAspectFit
        clearSelectionImage.translatesAutoresizingMaskIntoConstraints = false
        clearSelectionImage.widthAnchor.constraint(equalToConstant: 10).isActive = true
        
        self.clearSelectionView.addArrangedSubview(clearSelectionText)
        self.clearSelectionView.addArrangedSubview(clearSelectionImage)
        
        self.clearSelectionView.stackProperties(axis: .horizontal, spacing: 5, alignment: .fill, distribution: .fillProportionally)
        
        // add tap gesture action
        let clearActionTap = UITapGestureRecognizer(target: self, action: #selector(self.clearAll))
        self.clearSelectionView.addGestureRecognizer(clearActionTap)
        
        // By default - set as hidden
        self.clearSelectionView.isHidden = true
    }
    
    func moveBrandsSelectorView(index: Int) {
        let indexLength = self.frame.width / CGFloat(self.brands?.count ?? 1)
        self.brandsSelectorLeadingConstraint?.constant = indexLength * CGFloat(index)
    }
    
    func changeRecipeListHeader(numberOfRecipesSelected: Int, maxRecipes: Int) {
        self.headerLabel.text = numberOfRecipesSelected > 0 ? "\(numberOfRecipesSelected) of \(maxRecipes)  Selected" : "Choose Recipes:"
        
        UIView.animate(withDuration: 0.5) {
            self.clearSelectionView.isHidden = numberOfRecipesSelected > 0 ? false : true
        }
    }
    
    @objc func clearAll() {
        self.brandDashboardControllerDelegate?.clearSelections()
        self.brandDashboardControllerDelegate?.lockUnlockScrollView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
}
