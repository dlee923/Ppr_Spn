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
        self.isPagingEnabled = true
        self.registerCells()
        self.dataSource = self
        self.delegate = self
    }
    
    var menuOptionsObj: MenuOptionObj? {
        didSet {
            self.reloadData()
        }
    }
    weak var mealPrepFinishedDelegate: MealPrepFinishedDelegate?
    
    private func registerCells() {
        self.register(UINib(nibName: "\(MealsPrepCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "mealsPrepCollectionViewCell")
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
        return (self.menuOptionsObj?.selectedMenuOptions.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mealsPrepCollectionViewCell", for: indexPath) as? MealsPrepCollectionViewCell {
            let menuOption = self.menuOptionsObj?.selectedMenuOptions[indexPath.item]
            cell.menuOption = menuOption
            cell.mealPrepFinishedDelegate = self.mealPrepFinishedDelegate
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension MealsPrepCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
