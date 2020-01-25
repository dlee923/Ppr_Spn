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
        self.setup()
    }
    
    private func setup() {
        self.delegate = self
        self.dataSource = self
        self.registerCells()
    }
    
    private func registerCells() {
        self.register(InstructionsImgCollectionViewCell.self, forCellWithReuseIdentifier: "InstructionsImgCollectionViewCell")
    }
    
    var menuOption: MenuOption?
    var instructionsViewControllerDelegate: InstructionsViewControllerDelegate?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension InstructionsImgCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightMultiplier = CGFloat(self.frame.height) / CGFloat(self.menuOption?.recipe?.instructionImages?.count ?? 0)
        let size = CGSize(width: collectionView.frame.width, height: heightMultiplier)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstructionsImgCollectionViewCell", for: indexPath) as? InstructionsImgCollectionViewCell {
            cell.instructionImage.image = self.menuOption?.recipe?.instructionImages?[indexPath.item]
            cell.stepLabelNumber.text = "\(indexPath.item + 1)"
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // scroll to big view item
        self.instructionsViewControllerDelegate?.selectInstrutionsPane(number: indexPath.item)
        
        // deselect mini pane item
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            for selectedIndexPath in selectedItems {
                if selectedIndexPath != indexPath {
                    collectionView.deselectItem(at: indexPath, animated: false)
                }
            }
        }
        
        // color selected mini pane item
        if let cell = collectionView.cellForItem(at: indexPath) as? InstructionsImgCollectionViewCell {
            cell.stepLabelNumber.backgroundColor = UIColor.color5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? InstructionsImgCollectionViewCell {
            cell.stepLabelNumber.backgroundColor = UIColor.clear
        }
    }
    
}
