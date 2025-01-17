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
    
    // MARK:  Variables
    var isSelect: Bool?
    
    // MARK:  UI Elements
    var thumbnailView = UIImageView()
    var titleView = UILabel()
    var titleName = String()
    var subtitleView = UILabel()
    var caloriesLabel = UILabel()
    let titleViewColor = UIColor.themeColor2
    let titleViewColorSelected = UIColor.themeColor4
    var selectionCheckMarkView = UIView()
    let thumbnailShadow = UIView()
    
    // MARK:  Data Variables
    var menuOption: MenuOption?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.isSelect = nil
        self.titleView.textColor = self.titleViewColor
        self.subtitleView.textColor = self.titleViewColor
        self.selectionCheckMarkView.isHidden = true
    }
    
    private func setup() {
        // initialize with null colors until data is passed
        self.setNullColors()
        self.addViewThumbnail()
        self.addSelectionCheckmark()
        self.addViewTitle()
        self.addViewSubtitle()
//        self.addCaloriesLabel()
//        self.addThumbnailShadow()
        self.tintColor = self.titleViewColorSelected
        self.isUserInteractionEnabled = false
    }
    
    func setColors() {
        self.backgroundColor = UIColor.clear
        self.subtitleView.textColor = UIColor.black.withAlphaComponent(0.7)
        self.subtitleView.backgroundColor = UIColor.clear
        self.titleView.textColor = self.titleViewColor
        self.caloriesLabel.textColor = UIColor.themeColor2
    }
    
    func setHighlightColors() {
        self.selectionCheckMarkView.isHidden = self.isSelect == true ? false : true
        self.titleView.textColor = isSelect == false || isSelect == nil ? self.titleViewColor : self.titleViewColorSelected
        self.subtitleView.textColor = isSelect == false || isSelect == nil ? self.titleViewColor : self.titleViewColorSelected
    }
    
    private func setNullColors() {
        self.thumbnailView.backgroundColor = UIColor.themeColorNull
        self.subtitleView.backgroundColor = UIColor.themeColorNull
        self.caloriesLabel.textColor = UIColor.themeColor1
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
    
    private func addThumbnailShadow() {
        self.insertSubview(self.thumbnailShadow, belowSubview: self.thumbnailView)
        self.thumbnailShadow.layer.cornerRadius = 5
        
        self.thumbnailShadow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.thumbnailShadow.leadingAnchor.constraint(equalTo: self.thumbnailView.leadingAnchor),
            self.thumbnailShadow.topAnchor.constraint(equalTo: self.thumbnailView.topAnchor),
            self.thumbnailShadow.trailingAnchor.constraint(equalTo: self.thumbnailView.trailingAnchor),
            self.thumbnailShadow.heightAnchor.constraint(equalTo: self.thumbnailView.heightAnchor)
        ])
        
        self.thumbnailShadow.addShadow(path: UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height * 0.6),
                                                          byRoundingCorners: UIRectCorner.allCorners,
                                                          cornerRadii: CGSize(width: 5, height: 5)),
                                       color: .black,
                                       offset: CGSize(width: 2.0, height: 2.0),
                                       radius: 2,
                                       opacity: 0.2)
    }
    
    private func addSelectionCheckmark() {
        self.addSubview(selectionCheckMarkView)
        self.selectionCheckMarkView.isHidden = true
        self.selectionCheckMarkView.layer.borderWidth = 3
        self.selectionCheckMarkView.layer.borderColor = self.titleViewColorSelected.cgColor
        self.selectionCheckMarkView.backgroundColor = UIColor.themeColor2.withAlphaComponent(0.2)
        
        self.selectionCheckMarkView.contentMode = .scaleAspectFill
        self.selectionCheckMarkView.layer.cornerRadius = 5
        
        self.selectionCheckMarkView.translatesAutoresizingMaskIntoConstraints = false
        self.selectionCheckMarkView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.selectionCheckMarkView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.selectionCheckMarkView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        self.selectionCheckMarkView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
        
        let selectionCheckMark = UIImageView()
        selectionCheckMark.translatesAutoresizingMaskIntoConstraints = false
        selectionCheckMark.image = UIImage(named: "checkmark")?.withRenderingMode(.alwaysTemplate)
        selectionCheckMark.contentMode = .scaleAspectFit
        self.selectionCheckMarkView.addSubview(selectionCheckMark)
        NSLayoutConstraint.activate([
            selectionCheckMark.centerXAnchor.constraint(equalTo: self.selectionCheckMarkView.centerXAnchor),
            selectionCheckMark.centerYAnchor.constraint(equalTo: self.selectionCheckMarkView.centerYAnchor),
            selectionCheckMark.widthAnchor.constraint(equalTo: self.selectionCheckMarkView.widthAnchor, multiplier: 0.3),
            selectionCheckMark.heightAnchor.constraint(equalTo: self.selectionCheckMarkView.widthAnchor, multiplier: 0.3)
        ])
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
    
    func setAttributedTitle(title: String) {
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
        self.caloriesLabel.font = UIFont.fontCoolvetica?.withSize(10)
        self.caloriesLabel.textAlignment = .right
        self.addSubview(self.caloriesLabel)
        
        self.caloriesLabel.translatesAutoresizingMaskIntoConstraints = false
        self.caloriesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.caloriesLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        self.caloriesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        self.caloriesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
