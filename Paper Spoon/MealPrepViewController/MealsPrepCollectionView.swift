//
//  MealsPrepCollectionView.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/25/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class MealsPrepCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        if let flowLayout = layout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        
        self.setup()
    }
    
    private func setup() {
        self.backgroundColor = UIColor.color1
        self.registerCells()
    }
    
    var menuOptionsObj: MenuOptionObj?
    
    private func registerCells() {
        self.register(UINib(nibName: "MealsPrepCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "mealsPrepCollectionViewCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension MealsPrepCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.menuOptionsObj?.selectedMenuOptions.count ?? 0) - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mealsPrepCollectionViewCell", for: indexPath) as? MealsPrepCollectionViewCell {
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension MealsPrepCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width - 10, height: self.frame.height - 10)
    }
    
}
