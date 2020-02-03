//
//  MealKitsCollectionView.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/31/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class MealKitsCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.setup()
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    // MARK:  Variables
    var menuOptionsObj: MenuOptionObj?
    
    // MARK:  Delegates
    var mealKitSelectionViewControllerDelegate: MealKitSelectionViewControllerDelegate?
    var parentViewControllerDelegate: ParentViewControllerDelegate?
    var favCollectionViewControllerDelegate: FavCollectionViewControllerDelegate?
    
    // MARK: - Cell Colors
    let colors = [UIColor.color1,
                  UIColor.color2,
                  UIColor.color3,
                  UIColor.color4,
                  UIColor.color5,
                  UIColor.color6,
                  UIColor.color7,
                  UIColor.color8]
    
    private func setup() {
        self.backgroundColor = UIColor.themeColor1
        self.register(MealKitsCollectionViewCell.self, forCellWithReuseIdentifier: "mealKitsCollectionViewCell")
        self.register(EmptyMealKitsCell.self, forCellWithReuseIdentifier: "emptyMealKitsCell")
        self.delegate = self
        self.dataSource = self
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

extension MealKitsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return max(self.menuOptionsObj?.kittedMenuOptions.count ?? 1, 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let _ = collectionView.cellForItem(at: indexPath) as? EmptyMealKitsCell {
            self.parentViewControllerDelegate?.changeViewController(index: 2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let preppedMenuOptionsCount = menuOptionsObj?.kittedMenuOptions.count
        
        if preppedMenuOptionsCount == 0 || preppedMenuOptionsCount == nil {
            if let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyMealKitsCell", for: indexPath) as? EmptyMealKitsCell {
                return emptyCell
            } else {
                return UICollectionViewCell()
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mealKitsCollectionViewCell", for: indexPath) as? MealKitsCollectionViewCell {
                
                let colorIndex = indexPath.item % self.colors.count
                
                cell.splashColor = self.colors[colorIndex]
                cell.modifyColors()
                
                cell.mealKitSelectionViewControllerDelegate = self.mealKitSelectionViewControllerDelegate
                cell.favCollectionViewControllerDelegate = self.favCollectionViewControllerDelegate
                
                let menuOption = menuOptionsObj?.kittedMenuOptions[indexPath.item]
                cell.menuOption = menuOption
                
                return cell
            } else {
                return UICollectionViewCell()
            }
        }
    }
}

extension MealKitsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
