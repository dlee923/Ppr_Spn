//
//  BrandData.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 12/15/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

struct Brand {
    var name: BrandType
    var image: UIImage
    var largeImage: UIImage
}

enum BrandType {
    case HelloFresh
    case BlueApron
    case HomeChef
    case EveryPlate
    case Plated
    case PurpleCarrot
}
