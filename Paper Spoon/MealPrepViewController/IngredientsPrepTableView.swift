//
//  IngredientsPrepTableView.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/31/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class IngredientsPrepTableView: UITableView {

    var recipe: Recipe?

}


extension IngredientsPrepTableView: UITableViewDelegate {
    
}

extension IngredientsPrepTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfIngredients = self.recipe?.ingredients?.count
        return numberOfIngredients ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ingredientsPrepTableViewCell")
        let ingredient = self.recipe?.ingredients?[indexPath.row]
        cell.textLabel?.text = ingredient?.name
        return UITableViewCell()
    }
    
    
}
