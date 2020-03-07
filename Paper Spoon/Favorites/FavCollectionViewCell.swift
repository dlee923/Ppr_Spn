//
//  FavCollectionViewCell.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 1/26/20.
//  Copyright © 2020 DLEE. All rights reserved.
//

import UIKit

class FavCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        self.addImageView()
        self.addFavTitle()
        self.addFavSubtitle()
        self.addRatingView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:  Object
    var menuOption: MenuOption? {
        didSet {
            self.imageView.image = self.menuOption?.recipe?.recipeImage
            self.recipeTitle.text = " \(self.menuOption?.recipeName ?? "") "
            self.recipeSubtitle.text = " \(self.menuOption?.recipeSubtitle ?? "") "
            
            guard let brandImage = UIImage(named: brandImages[self.menuOption!.brandType]!) else { return }
            self.brandImage.image = brandImage
            
            self.recipeTitle.sizeToFit()
            self.recipeSubtitle.sizeToFit()
        }
    }
    
    // MARK:  UI Elemnts
    var imageView = UIImageView()
    var recipeTitle = UILabel()
    var recipeSubtitle = UILabel()
    var userRating = RatingView()
    var brandImage = UIImageView()
    
    // MARK:  Brand image dictionary
    let brandImages: [BrandType:String] = [.HelloFresh : "hellofresh_x1.png",
                                           .BlueApron : "blueapron_x1.png",
                                           .HomeChef : "homechef_x1.png"]
    
    private func addImageView() {
        self.addSubview(imageView)
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.backgroundColor = .purple
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func addFavTitle() {
        self.addSubview(self.recipeTitle)
        self.recipeTitle.backgroundColor = UIColor.themeColor1
        self.recipeTitle.font = UIFont.fontBebas?.withSize(20)
        self.recipeTitle.textColor = UIColor.themeColor1
        self.recipeTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.recipeTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.recipeTitle.topAnchor.constraint(equalTo: self.centerYAnchor),
            self.recipeTitle.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.20),
        ])
        
    }
    
    private func addFavSubtitle() {
        self.addSubview(self.recipeSubtitle)
        self.recipeSubtitle.backgroundColor = UIColor.themeColor1
        self.recipeSubtitle.font = UIFont.fontBebas?.withSize(13)
        self.recipeSubtitle.textColor = UIColor.themeColor1
        self.recipeSubtitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.recipeSubtitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.recipeSubtitle.topAnchor.constraint(equalTo: self.recipeTitle.bottomAnchor),
            self.recipeSubtitle.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.20),
        ])
    }
    
    private func addRatingView() {
        self.addSubview(self.userRating)
        self.userRating.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.userRating.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            self.userRating.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.userRating.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            self.userRating.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -15)
        ])
    }
    
}
