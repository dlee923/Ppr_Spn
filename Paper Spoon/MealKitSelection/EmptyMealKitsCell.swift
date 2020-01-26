//
//  EmptyMealKitsCell.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 10/27/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class EmptyMealKitsCell: EmptyCollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.image.image = UIImage(named: "sad_chef")
        self.message.text = "Looks like you need to prepare some recipe meal kits first!"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
