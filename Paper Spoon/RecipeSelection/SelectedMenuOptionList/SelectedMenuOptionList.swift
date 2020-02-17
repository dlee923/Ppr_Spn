//
//  SelectedMenuOptionList.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 2/9/20.
//  Copyright © 2020 DLEE. All rights reserved.
//

import UIKit

class SelectedMenuOptionList: OptionListCollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.registerCells()
        self.backgroundColor = UIColor.themeColor1
    }
    
    // MARK:  Variables
    var selectedMenuOptions: [MenuOption]?
    
    func registerCells() {
        self.register(MenuOptionListCell.self, forCellWithReuseIdentifier: "selectedMenuOptionListCell")
        self.register(PlainHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "selectedMenuOptionListHeader")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedMenuOptions?.count ?? 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectedMenuOptionListCell", for: indexPath) as? MenuOptionListCell {
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? MenuOptionListCell {
            
            cell.menuOption = selectedMenuOptions?[indexPath.item]

            // cell properties to set if not currently set
            if cell.menuOption?.recipeName == cell.titleName {
                return
            } else {
                // set normal colors if data exists
                if cell.menuOption?.recipe != nil { cell.setColors() }

                cell.titleName = cell.menuOption?.recipeName ?? ""
                cell.setAttributedTitle(title: cell.menuOption?.recipeName ?? "")
                cell.subtitleView.text = cell.menuOption?.recipeSubtitle
                cell.thumbnailView.image = cell.menuOption?.recipe?.thumbnail
                cell.caloriesLabel.text = "\(Int(cell.menuOption?.recipe?.nutrition?.calories?.amount ?? 0)) Calories"
            }
            
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "selectedMenuOptionListHeader", for: indexPath) as? PlainHeaderCell {
            
            header.titleLabel.numberOfLines = 2
            let titleText = NSMutableAttributedString(string: "Selected Options\nTap the above button to select new recipes!")
            titleText.addAttributes([NSAttributedString.Key.font : UIFont.fontSunflower?.withSize(10) ?? UIFont.systemFont(ofSize: 20)], range: NSRange(location: 0, length: titleText.length))
            titleText.addAttributes([NSAttributedString.Key.font : UIFont.fontSunflower?.withSize(20) ?? UIFont.systemFont(ofSize: 20)], range: NSRange(location: 0, length: 16))
            
            header.titleLabel.attributedText = titleText
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.frame.width, height: 55)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
