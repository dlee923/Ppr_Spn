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
    
    var thumbnailView = UIImageView()
    var titleView = UILabel()
    var menuOption: MenuOption? {
        didSet {
            self.titleView.text = self.menuOption?.recipeName
        }
    }
    
    private func setup() {
        self.backgroundColor = .yellow
        self.addViewThumbnail()
        self.addViewTitle()
    }
    
    private func addViewThumbnail() {
        self.addSubview(thumbnailView)
        self.thumbnailView.backgroundColor = .gray
        self.thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        self.thumbnailView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.thumbnailView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        self.thumbnailView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        self.thumbnailView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    private func addViewTitle() {
        self.addSubview(titleView)
        self.titleView.backgroundColor = .green
        self.titleView.translatesAutoresizingMaskIntoConstraints = false
        self.titleView.leadingAnchor.constraint(equalTo: self.thumbnailView.trailingAnchor, constant: 0).isActive = true
        self.titleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        self.titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        self.titleView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
