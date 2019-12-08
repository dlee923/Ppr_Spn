//
//  IngredientsPrepTableView.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/31/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class IngredientsPrepCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.setup()
    }
    
    var recipe: Recipe? {
        didSet {
            self.contentInset = UIEdgeInsets(top: 210, left: 0, bottom: 0, right: 0)
        }
    }
    
    private func setup() {
        self.backgroundColor = .clear
        self.delegate = self
        self.dataSource = self
        self.registerCells()
    }
    
    private func registerCells() {
        self.register(IngredientsPrepCollectionViewCell.self, forCellWithReuseIdentifier: "ingredientsPrepTableViewCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

}

extension IngredientsPrepCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfIngredients = self.recipe?.ingredients?.count
        return numberOfIngredients ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ingredientsPrepTableViewCell", for: indexPath) as? IngredientsPrepCollectionViewCell {
            let ingredient = self.recipe?.ingredients?[indexPath.row]
            cell.ingredient = ingredient

            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    
}

extension IngredientsPrepCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellDimension = (self.frame.width / 3) - 5
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? IngredientsPrepCollectionViewCell {
            cell.ingredient?.isPacked = cell.ingredient?.isPacked == true ? false : true
            cell.isPackedFunction()
        }
    }
}
