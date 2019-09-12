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
    var subtitleView = UILabel()
    var caloritesLabel = UILabel()
    let titleViewColor = UIColor.themeColor1
    let titleViewColorSelected = UIColor.color5
    var menuOption: MenuOption? {
        didSet {
            self.setAttributedTitle(title: self.menuOption?.recipeName ?? "")
            self.subtitleView.text = self.menuOption?.recipeSubtitle
            self.thumbnailView.image = self.menuOption?.recipe?.thumbnail
            self.caloritesLabel.text = "\(Int(self.menuOption?.recipe?.nutrition?.calories?.amount ?? 0)) Calories"
            self.isSelect = self.menuOption?.isSelected
            self.titleView.backgroundColor = isSelect == false || isSelect == nil ? self.titleViewColor : self.titleViewColorSelected
        }
    }
    
    private func setup() {
        self.setColors()
        self.addViewThumbnail()
        self.addViewTitle()
        self.addViewSubtitle()
        self.addCaloriesLabel()
    }
    
    private func setColors() {
        self.backgroundColor = UIColor.themeColor1
        self.thumbnailView.backgroundColor = UIColor.themeColor1
        self.subtitleView.textColor = UIColor.black.withAlphaComponent(0.7)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.isSelect = nil
        self.titleView.backgroundColor = self.titleViewColor
    }
    
    private func addViewThumbnail() {
        self.addSubview(thumbnailView)
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
        self.titleView.font = UIFont.fontBebas?.withSize(20)
        self.titleView.numberOfLines = 2
        
        self.addSubview(titleView)
        
        self.titleView.translatesAutoresizingMaskIntoConstraints = false
        self.titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.titleView.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: 10).isActive = true
        self.titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        self.titleView.sizeToFit()
    }
    
    private func setAttributedTitle(title: String) {
        let attributedString = NSMutableAttributedString(string: title)
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineHeightMultiple = 0.75
        paragraphStyle.minimumLineHeight = 20
        
        // *** Apply attribute to string ***
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        // *** Set Attributed String to your label ***
        self.titleView.attributedText = attributedString
    }
    
    private func addViewSubtitle() {
        self.subtitleView.font = UIFont.fontBebas?.withSize(13)
        self.subtitleView.numberOfLines = 2
        self.addSubview(self.subtitleView)
        
        self.subtitleView.translatesAutoresizingMaskIntoConstraints = false
        self.subtitleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.subtitleView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 0).isActive = true
        self.subtitleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        self.subtitleView.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    private func addCaloriesLabel() {
        self.caloritesLabel.font = UIFont.fontCoolvetica?.withSize(10)
        self.addSubview(self.caloritesLabel)
        
        self.caloritesLabel.translatesAutoresizingMaskIntoConstraints = false
        self.caloritesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.caloritesLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        self.caloritesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        self.caloritesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
