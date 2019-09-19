//
//  IngredientsPrepTableView.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/31/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class IngredientsPrepTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setup()
        
    }
    
    var recipe: Recipe? {
        didSet {
            self.contentInset = UIEdgeInsets(top: 180, left: 0, bottom: 0, right: 0)
        }
    }
    
    private func setup() {
        self.backgroundColor = .clear
        self.delegate = self
        self.dataSource = self
        self.registerCells()
    }
    
    private func registerCells() {
        self.register(IngredientsPrepTableViewCell.self, forCellReuseIdentifier: "ingredientsPrepTableViewCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

}


extension IngredientsPrepTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? IngredientsPrepTableViewCell {
            cell.ingredient?.isPacked = cell.ingredient?.isPacked == true ? false : true
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

extension IngredientsPrepTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfIngredients = self.recipe?.ingredients?.count
        return numberOfIngredients ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsPrepTableViewCell", for: indexPath) as? IngredientsPrepTableViewCell {
            let ingredient = self.recipe?.ingredients?[indexPath.row]
            cell.ingredient = ingredient
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}

