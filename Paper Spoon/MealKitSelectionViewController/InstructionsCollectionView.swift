//
//  InstructionsCollectionView.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 9/7/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class InstructionsCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.setup()
    }
    
    private func setup() {
        self.backgroundColor = UIColor.color7
        self.isPagingEnabled = true
        self.delegate = self
        self.dataSource = self
        self.register(InstructionsCollectionViewCell.self, forCellWithReuseIdentifier: "instructionsCollectionViewCell")
    }
    
    var recipe: Recipe? { didSet { self.reloadData() } }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

extension InstructionsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recipe?.instructions?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "instructionsCollectionViewCell", for: indexPath) as? InstructionsCollectionViewCell {
            let instructions = self.recipe?.instructions?[indexPath.item]
            cell.instructions = instructions
            let instructionImage = self.recipe?.instructionImages?[indexPath.item]
            cell.instructionsImage.image = instructionImage
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension InstructionsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
