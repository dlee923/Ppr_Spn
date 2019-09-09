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
    
    var menuOptionsObj: MenuOptionObj?
    
    private func setup() {
        self.backgroundColor = UIColor.themeColor1
        self.register(MealKitsCollectionViewCell.self, forCellWithReuseIdentifier: "mealKitsCollectionViewCell")
        self.delegate = self
        self.dataSource = self
        self.isPagingEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

extension MealKitsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuOptionsObj?.selectedMenuOptions.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mealKitsCollectionViewCell", for: indexPath) as? MealKitsCollectionViewCell {
            cell.scrollViewLockDelegate = self
            let menuOption = self.menuOptionsObj?.selectedMenuOptions[indexPath.item]
            cell.menuOption = menuOption
            return cell
        } else {
            return UICollectionViewCell()
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

protocol ScrollViewLockDelegate: AnyObject {
    func lockScrollView()
    func unlockScrollView()
}

extension MealKitsCollectionView: ScrollViewLockDelegate {
    func lockScrollView() {
        self.isScrollEnabled = false
    }
    
    func unlockScrollView() {
        self.isScrollEnabled = true
    }
    
    
}
