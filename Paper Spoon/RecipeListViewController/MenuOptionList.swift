//
//  MenuOptionList.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/4/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class MenuOptionList: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.setup()
    }
    
    private func setup() {
        self.delegate = self
        self.dataSource = self
        self.register(MenuOptionListCell.self, forCellWithReuseIdentifier: "menuOptionListCell")
//        self.register(MenuOptionListHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "menuOptionListHeaderCell")
        self.setColors()
    }
    
    var menuOptionsObj: MenuOptionObj?
    
    private func setColors() {
        self.backgroundColor = UIColor.themeColor1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuOptionsObj?.menuOptions?.count ?? 6
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "menuOptionListHeaderCell", for: indexPath) as? MenuOptionListHeaderCell{
//            return header
//        } else {
//            return UICollectionViewCell()
//        }
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: self.frame.width, height: 100)
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuOptionListCell", for: indexPath) as? MenuOptionListCell {
            cell.menuOption = menuOptionsObj?.menuOptions?[indexPath.item]
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.frame.width * 0.5) - 5, height: self.frame.width * 0.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MenuOptionListCell {
            // mark cell as selected / unselected when tapped
            cell.isSelect = cell.isSelect == false || cell.isSelect == nil ? true : false
            
            // UI change to cell based on selection
            cell.titleView.backgroundColor = cell.isSelect == true ? cell.titleViewColorSelected : cell.titleViewColor
            
            // add or remove menu option to selected array
            guard let menuOption = cell.menuOption else { return }
            self.selectMenuOption(menuOption: menuOption)
        }
    }
    
    private func selectMenuOption(menuOption: MenuOption) {
        // check if menuOptionObj exists in selectedMenuOptions and remove otherwise add to array
        if let alreadySelectedIndex = self.menuOptionsObj?.selectedMenuOptions.firstIndex(where: { $0.recipeName == menuOption.recipeName }) {
            self.menuOptionsObj?.selectedMenuOptions.remove(at: alreadySelectedIndex)
            
            // mark as not selected for prepareForReuse
            menuOption.isSelected = false
        } else {
            self.menuOptionsObj?.selectedMenuOptions.append(menuOption)
            
            // mark as selected for prepareForReuse
            menuOption.isSelected = true
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

//class MenuOptionListHeaderCell: UICollectionViewCell {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.addHeaderLabel()
//    }
//
//    let headerLabel = UILabel()
//
//    private func addHeaderLabel() {
//        self.headerLabel.font = UIFont.fontSunflower?.withSize(30)
//        self.headerLabel.text = "Choose Recipes:"
//        self.addSubview(self.headerLabel)
//
//        self.headerLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            self.headerLabel.topAnchor.constraint(equalTo: self.topAnchor),
//            self.headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
//            self.headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
//            self.headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//        ])
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//}
