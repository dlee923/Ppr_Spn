//
//  FavHeaderCell.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 1/27/20.
//  Copyright © 2020 DLEE. All rights reserved.
//

import UIKit

class FavHeaderCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTitle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addTitle()
    }
    
    let titleLabel = UILabel()
    
    func addTitle() {
        self.addSubview(self.titleLabel)
        titleLabel.backgroundColor = UIColor.themeColor1
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        
        let titleText = NSMutableAttributedString(string: "Favorite\nRecipes")
        titleText.addAttributes([NSAttributedString.Key.font : UIFont.fontSunflower?.withSize(20) ?? UIFont.systemFont(ofSize: 20)], range: NSRange(location: 0, length: 8))
        print(titleText.length)
        
//        titleText.addAttributes([NSAttributedString.Key.font : UIFont.fontSunflower?.withSize(10) ?? UIFont.systemFont(ofSize: 10)], range: NSRange(location: 9, length: titleText.length-1))
        
        titleLabel.attributedText = titleText
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
}
