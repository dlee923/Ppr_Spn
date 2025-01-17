//
//  BrandPickerView.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 9/14/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class BrandsCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        // switch to horizontal scrolling
        if let layout = layout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        // additional setup
        self.setup()
    }
    
    var brands: [Brand]?
    
    private func setup() {
        self.backgroundColor = .clear
        self.delegate = self
        self.dataSource = self
        self.register(BrandsCollectionViewCell.self, forCellWithReuseIdentifier: "brandCollectionViewCell")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.brands?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandCollectionViewCell", for: indexPath) as? BrandsCollectionViewCell {
            cell.brand = self.brands?[indexPath.item]
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / CGFloat(self.brands?.count ?? 0), height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? BrandsCollectionViewCell {
            cell.brandImage.layer.shadowColor = UIColor.themeColor4.cgColor
        }
        
        for x in 0..<collectionView.visibleCells.count {
            if x != indexPath.item {
                guard let otherCell = collectionView.visibleCells[x] as? BrandsCollectionViewCell else { return }
                otherCell.brandImage.layer.shadowColor = UIColor.black.cgColor
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
