//
//  EmptyCompiledIngredientsCell.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 10/19/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class EmptyCompiledIngredientsCell: EmptyTableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.cellImageView.image = UIImage(named: "sad_chef")
        self.message.text = "Looks like you need to select some recipes first!"
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

