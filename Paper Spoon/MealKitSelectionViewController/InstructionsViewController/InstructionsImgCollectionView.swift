//
//  InstructionsImgCollectionView.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 12/14/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class InstructionsImgCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    private func setup() {
        self.delegate = self
        self.dataSource = self
    }
    
    private func registerCells() {
        self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
    }
    
    var menuOption: MenuOption?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension InstructionsImgCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = collectionView.frame.height / (self.menuOption?.recipe?.instructionImages?.count ?? 0)
        let size = CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
        return size
    }
}

extension InstructionsImgCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuOption?.recipe?.instructionImages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath) as? UICollectionViewCell {
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
