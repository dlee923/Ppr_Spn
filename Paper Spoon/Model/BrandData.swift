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

enum BrandType: String {
    case HelloFresh = "HelloFresh"
    case BlueApron = "BlueApron"
    case HomeChef = "HomeChef"
    case EveryPlate = "EveryPlate"
    case Plated = "Plated"
    case PurpleCarrot = "PurpleCarrot"
    case MarleySpoon = "MarleySpoon"
}
