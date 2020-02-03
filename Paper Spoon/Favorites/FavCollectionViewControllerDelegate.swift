//
//  FavCollectionViewControllerDelegate.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 1/30/20.
//  Copyright © 2020 DLEE. All rights reserved.
//

import Foundation

protocol FavCollectionViewControllerDelegate: AnyObject {
    func addToFavorites(menuOption: MenuOption)
    func removeFromFavorites(menuOption: MenuOption)
}

extension FavCollectionViewController: FavCollectionViewControllerDelegate {
    func addToFavorites(menuOption: MenuOption) {
        self.favoriteMenuOptions.append(menuOption)
    }
    
    func removeFromFavorites(menuOption: MenuOption) {
        self.favoriteMenuOptions.removeAll(where: { $0.recipeName == menuOption.recipeName })
    }
}
