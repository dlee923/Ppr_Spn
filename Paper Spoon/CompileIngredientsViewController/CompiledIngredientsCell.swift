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
        self.measureLbl.backgroundColor = UIColor.themeColor1
        self.measureAmount.backgroundColor = UIColor.themeColor1
    }

    @IBOutlet weak var ingredientName: UILabel!
    @IBOutlet weak var ingredientImg: UIImageView!
    @IBOutlet weak var measureAmount: UILabel!
    @IBOutlet weak var measureLbl: UILabel!
    
    var ingredient: Ingredients? {
        didSet {
            self.ingredientName.text = self.ingredient?.name
            self.measureAmount.text = String(describing: self.ingredient?.amount ?? 1)
            self.measureLbl.text = self.ingredient?.measurementType
            self.ingredientImg.image = self.ingredient?.image
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.backgroundColor = UIColor.themeColor1
    }
    
}
