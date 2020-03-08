//
//  FavCollectionViewController.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 1/26/20.
//  Copyright © 2020 DLEE. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FavCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.backgroundColor = UIColor.themeColor1
        self.collectionView.dataSource = self
        
        // Do any additional setup after loading the view.
        self.registerCells()
    }
    
    var favoriteMenuOptions = [MenuOption]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    internal func registerCells() {
        // Register cell classes
        self.collectionView.register(FavCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.register(EmptyCollectionViewCell.self, forCellWithReuseIdentifier: "emptyCell")
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "default")
        self.collectionView.register(PlainHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "favHeader")
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: 100)
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width - 10, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        //here, be sure you set the font type and size that matches the one set in the storyboard label
        label.font = UIFont.fontSunflower?.withSize(20)
        label.text = "Favorite Recipes"
        label.textColor = UIColor.themeColor2
        label.sizeToFit()
        return CGSize(width: collectionView.frame.width, height: label.frame.height + 30)
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return max(self.favoriteMenuOptions.count, 1)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.favoriteMenuOptions.count {
        case 0 :
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyCell", for: indexPath) as? EmptyCollectionViewCell {
                cell.message.text = "You don't have any favorite recipes to show here yet!"
                return cell
            } else {
                return UICollectionViewCell()
            }
        default:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FavCollectionViewCell {
                cell.menuOption = self.favoriteMenuOptions[indexPath.item]
                return cell
            } else {
                return UICollectionViewCell()
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width - 10, height: 100)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "favHeader", for: indexPath) as? PlainHeaderCell {
            
            header.titleLabel.numberOfLines = 2
            header.titleLabel.textColor = UIColor.themeColor2
            
            let titleText = NSMutableAttributedString(string: "Favorite Recipes\nSelect from your favorites here!")
            titleText.addAttributes([NSAttributedString.Key.font : UIFont.fontSunflower?.withSize(10) ?? UIFont.systemFont(ofSize: 20)], range: NSRange(location: 0, length: titleText.length))
            titleText.addAttributes([NSAttributedString.Key.font : UIFont.fontSunflower?.withSize(20) ?? UIFont.systemFont(ofSize: 20)], range: NSRange(location: 0, length: 16))
            print(titleText.length)
            
            header.titleLabel.attributedText = titleText
            
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
