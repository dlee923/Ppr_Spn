//
//  CompiledIngredientsCell.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/17/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class CompiledIngredientsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.ingredientName.backgroundColor = UIColor.themeColor1
        self.measureAmount.backgroundColor = UIColor.themeColor1
        self.setFonts()
    }

    @IBOutlet weak var ingredientName: UILabel!
    @IBOutlet weak var ingredientImg: UIImageView!
    @IBOutlet weak var measureAmount: UILabel!
    @IBOutlet weak var shoppingIcon: UIImageView!
    
    var ingredient: Ingredients? {
        didSet {
            self.ingredientName.text = self.ingredient?.name
            self.measureAmount.text = "\(self.ingredient?.amount ?? 1) \(self.ingredient?.measurementType ?? "")"
            self.ingredientImg.image = self.ingredient?.image
        }
    }
    
    func setColors(isPurchased: Bool) {
        if isPurchased {
            self.ingredientName.textColor = UIColor.color4
            self.measureAmount.textColor = UIColor.color4
        } else {
            self.ingredientName.textColor = .black
            self.measureAmount.textColor = .black
        }
    }
    
    func setFonts() {
        self.measureAmount.font = UIFont.fontSunflower?.withSize(20)
        self.ingredientName.font = UIFont.fontCoolvetica?.withSize(10)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.selectionStyle = .none
        self.ingredientName.backgroundColor = UIColor.themeColor1
        self.measureAmount.backgroundColor = UIColor.themeColor1
        self.setColors(isPurchased: false)
        self.shoppingIcon.isHidden = true
    }
    
}
