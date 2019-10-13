//
//  EmptyCollectionViewCell.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 10/13/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class EmptyCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addEmptyContainer()
        self.addMessage()
        self.addImage()
    }
    
    var image = UIImageView()
    var message = UILabel()
    var emptyContainer = UIView()
    
    private func addEmptyContainer() {
        self.addSubview(self.emptyContainer)
        self.emptyContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.emptyContainer.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            self.emptyContainer.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            self.emptyContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.emptyContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func addImage() {
        self.emptyContainer.addSubview(self.image)
        self.image.alpha = 0.6
        self.image.contentMode = .scaleAspectFit
        self.image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.image.topAnchor.constraint(equalTo: self.emptyContainer.topAnchor),
            self.image.leadingAnchor.constraint(equalTo: self.emptyContainer.leadingAnchor),
            self.image.trailingAnchor.constraint(equalTo: self.emptyContainer.trailingAnchor),
            self.image.bottomAnchor.constraint(equalTo: self.message.topAnchor),
        ])
    }
    
    private func addMessage() {
        self.emptyContainer.addSubview(self.message)
        self.message.numberOfLines = 3
        self.message.alpha = 0.75
        self.message.textAlignment = .center
        self.message.textColor = UIColor.themeColor2
        self.message.font = UIFont.fontCoolvetica?.withSize(15)
        self.message.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.message.bottomAnchor.constraint(equalTo: self.emptyContainer.bottomAnchor),
            self.message.leadingAnchor.constraint(equalTo: self.emptyContainer.leadingAnchor),
            self.message.trailingAnchor.constraint(equalTo: self.emptyContainer.trailingAnchor),
            self.message.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class MealPrepEmptyCollectionViewCell: EmptyCollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image.image = UIImage(named: "sad_chef")
        self.message.text = "Looks like you need to select some recipes first!"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}