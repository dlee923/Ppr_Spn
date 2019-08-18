//
//  MenuOptionListCell.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/4/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class MenuOptionListCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    var isSelect: Bool?
    var thumbnailView = UIImageView()
    var titleView = UILabel()
    let titleViewColor = UIColor.white
    var menuOption: MenuOption? {
        didSet {
            self.titleView.text = self.menuOption?.recipeName
            self.thumbnailView.image = self.menuOption?.recipe?.thumbnail
        }
    }
    
    private func setup() {
        self.backgroundColor = .yellow
        self.addViewThumbnail()
        self.addViewTitle()
    }
    
    override func prepareForReuse() {
        self.titleView.backgroundColor = isSelect == false || isSelect == nil ? self.titleViewColor : .green
    }
    
    private func addViewThumbnail() {
        self.addSubview(thumbnailView)
        self.thumbnailView.backgroundColor = .gray
        self.thumbnailView.contentMode = .scaleAspectFill
        self.thumbnailView.layer.cornerRadius = 5
        self.thumbnailView.clipsToBounds = true
        
        self.thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        self.thumbnailView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.thumbnailView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.thumbnailView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        self.thumbnailView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
    }
    
    private func addViewTitle() {
        self.addSubview(titleView)
        self.titleView.backgroundColor = self.titleViewColor
        
        self.titleView.translatesAutoresizingMaskIntoConstraints = false
        self.titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.titleView.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: 0).isActive = true
        self.titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        self.titleView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
