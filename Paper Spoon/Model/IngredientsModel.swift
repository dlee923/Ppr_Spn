//
//  IngredientsModel.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 1/25/20.
//  Copyright © 2020 DLEE. All rights reserved.
//

import UIKit

class Ingredients: Equatable, NSCopying {
    
    var name: String
    var amount: Double?
    var measurementType: String?
    var isPacked: Bool?
    
    var imageLink: String?
    var image: UIImage?
    
    // confirm to Equatable protocol
    static func == (lhs: Ingredients, rhs: Ingredients) -> Bool {
        return lhs.name == rhs.name
    }
    
    init (name: String, amount: Double?, measurementType: String?, isPacked: Bool?, imageLink: String?, image: UIImage?) {
        self.name = name
        self.amount = amount
        self.measurementType = measurementType
        self.isPacked = isPacked
        self.imageLink = imageLink
        self.image = image
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let ingredientCopy = Ingredients(name: self.name, amount: self.amount, measurementType: self.measurementType, isPacked: self.isPacked, imageLink: self.imageLink, image: self.image)
        return ingredientCopy
    }
}
