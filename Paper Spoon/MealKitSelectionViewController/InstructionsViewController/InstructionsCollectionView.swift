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
        self.backgroundColor = UIColor.themeColor1
        self.isPagingEnabled = true
        self.delegate = self
        self.dataSource = self
        self.register(InstructionsCollectionViewCell.self, forCellWithReuseIdentifier: "instructionsCollectionViewCell")
    }
    
    var menuOption: MenuOption? { didSet { self.reloadData() } }
    
    // MARK:  Delegate
    var instructionsViewControllerDelegate: InstructionsViewControllerDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

extension InstructionsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuOption?.recipe?.instructions?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "instructionsCollectionViewCell", for: indexPath) as? InstructionsCollectionViewCell {
            
            switch self.menuOption?.brandType {
            case .HelloFresh:
                let instructions = self.menuOption?.recipe?.instructions?[indexPath.item]
                cell.instructions = instructions
            case .BlueApron :
                let instructionsHTML = self.menuOption?.recipe?.instructions?[indexPath.item].convertHtml()
                cell.instructionsHTML = instructionsHTML
            default : break
            }
            
            if let instructionImage = self.menuOption?.recipe?.instructionImages?[indexPath.item] {
                cell.instructionsImage.image = instructionImage
            }
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // select InstructionsImgCollectionViewCell
        self.instructionsViewControllerDelegate?.selectInstructionsMiniPane(number: indexPath.item)
    }
}
