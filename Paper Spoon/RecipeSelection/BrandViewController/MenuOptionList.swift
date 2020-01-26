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
        
        self.delegate = self
        self.dataSource = self
        
        self.contentInset = UIEdgeInsets(top: self.contentInsetValue - 10, left: 0, bottom: 0, right: 0)
        self.showsVerticalScrollIndicator = false
        
        self.registerCells()
        self.setColors()
    }
    
    private func registerCells() {
        self.register(MenuOptionListCell.self, forCellWithReuseIdentifier: "menuOptionListCell")
        self.register(MenuOptionListHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "menuOptionListHeader")
    }
    
    // MARK:  Variables
    var brandView: BrandType?
    var brand: Brand?
    let contentInsetValue: CGFloat = 100
    
    // MARK:  Object Variables
    var menuOptionsObj: MenuOptionObj?
    
    // MARK:  Delegates
    var brandDashboardControllerDelegate: BrandDashboardControllerDelegate?
    var parentViewControllerDelegate: ParentViewControllerDelegate?
    
    private func setColors() {
        self.backgroundColor = .clear
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let brandView = self.brandView {
            return menuOptionsObj?.menuOptions[brandView]?.count ?? 6
        } else {
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuOptionListCell", for: indexPath) as? MenuOptionListCell {
            guard let brandView = self.brandView else { return UICollectionViewCell() }
            cell.menuOption = menuOptionsObj?.menuOptions[brandView]?[indexPath.item]
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.frame.width * 0.5) - 5, height: self.frame.width * 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "menuOptionListHeader", for: indexPath) as? MenuOptionListHeader {
            header.brand = self.brand
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.frame.width - 10, height: self.frame.height * 0.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    var fadeOut: Bool?
    var fadePct: CGFloat?
    var fadePctSplashImg: CGFloat?
    
    
    // MARK:  Select option delegate method.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MenuOptionListCell {

            // check if not maxed out
            if (self.brandDashboardControllerDelegate?.isMaxedOut() ?? true) == false {
                // mark cell as selected / unselected when tapped
                cell.isSelect = cell.isSelect == false || cell.isSelect == nil ? true : false
            } else {
                // enable only deselecting if maxed out
                if cell.isSelect == true { cell.isSelect = false }
            }
            
            // UI change to cell based on selection
            cell.setHighlightColors()
            
            // add or remove menu option to selected array
            guard let menuOption = cell.menuOption else { return }
            self.brandDashboardControllerDelegate?.selectMenuOption(menuOption: menuOption)
            
            // modify recipe header
            self.brandDashboardControllerDelegate?.changeRecipeHeadertext()
            
            // show / hide compile button
            self.brandDashboardControllerDelegate?.showHideCompileButton()
            
            // lock / unlock scrolling
            self.brandDashboardControllerDelegate?.lockUnlockScrollView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
