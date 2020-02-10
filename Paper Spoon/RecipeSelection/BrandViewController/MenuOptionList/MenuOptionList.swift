//
//  MenuOptionList.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/4/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class MenuOptionList: OptionListCollectioView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.contentInset = UIEdgeInsets(top: self.contentInsetValue - 10, left: 0, bottom: 0, right: 0)
    }
    
    override func registerCells() {
        super.registerCells()
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let brandView = self.brandView {
            return menuOptionsObj?.menuOptions[brandView]?.count ?? 6
        } else {
            return 6
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuOptionListCell", for: indexPath) as? MenuOptionListCell {
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? MenuOptionListCell {
            if let brandView = self.brandView {
                cell.menuOption = menuOptionsObj?.menuOptions[brandView]?[indexPath.item]
                // properties to always set no matter
                cell.isSelect = cell.menuOption?.isSelected

                // set highlight colors if highlighted
                cell.setHighlightColors()

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

                    // enable once given a menu option
                    cell.isUserInteractionEnabled = true
                }
            }
        }
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
