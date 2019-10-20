//
//  IngredientsListCollectionView.swift
//  HF Test
//
//  Created by Daniel Lee on 5/12/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class IngredientsListCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // MARK: - Initialization
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.setup()
    }
    
    // MARK: - Mutable Properties
    var ingredients: [Ingredients]? {
        didSet {
            self.reloadData()
        }
    }
    var splashColor: UIColor?
    var headerHeight: CGFloat?
    
    // MARK: - Setup Methods
    private func setup() {
        self.backgroundColor = .white
        self.delegate = self
        self.dataSource = self
        self.registerCells()
    }
    
    private func registerCells() {
        self.register(IngredientsPillCell.self, forCellWithReuseIdentifier: "ingredientsPillCell")
        self.register(IngredientsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ingredientsHeader")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    // MARK: - Header Cell Methods
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ingredientsHeader", for: indexPath) as? IngredientsHeader {
            header.title.textColor = self.splashColor
            return header
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.frame.width, height: self.headerHeight ?? 10)
    }
    
    // MARK: - Cell Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellPadding: CGFloat = 25
        var title = ""
        if let ingredient = ingredients?[indexPath.item] {
            title = ingredient.name
        }
        if let font = IngredientsPillCell.ingredientPillFont {
            let width = title.size(withAttributes: [NSAttributedString.Key.font: font]).width + cellPadding
            return CGSize(width: width, height: 30)
        } else {
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ingredientsPillCell", for: indexPath) as? IngredientsPillCell {
            cell.ingredient.text = self.ingredients?[indexPath.item].name
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}


