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
    }
    
    var menuOptionsObj: MenuOptionObj?
    
    private func setup() {
        self.backgroundColor = UIColor.color2
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
        return UICollectionViewCell()
    }
}

extension MealKitsCollectionView: UICollectionViewDelegateFlowLayout {}
