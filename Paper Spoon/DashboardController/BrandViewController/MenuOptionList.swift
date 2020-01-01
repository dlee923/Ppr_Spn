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
        self.setColors()
    }
    
    // MARK:  Variables
    var brandView: BrandType?
    
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
        
        return CGSize(width: (self.frame.width * 0.5) - 5, height: self.frame.width * 0.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y > 0 {
            print("scrolling up")
            self.parentViewControllerDelegate?.showHideTabBar(isHidden: true)
        } else {
            print("scrolling down")
            self.parentViewControllerDelegate?.showHideTabBar(isHidden: false)
        }
    }
    
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
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
