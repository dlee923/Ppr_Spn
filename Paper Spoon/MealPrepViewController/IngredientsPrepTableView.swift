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
    
    var recipe: Recipe?
    
    private func setup() {
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .blue
        self.registerCells()
    }
    
    private func registerCells() {
        self.register(UITableViewCell.self, forCellReuseIdentifier: "ingredientsPrepTableViewCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

}


extension IngredientsPrepTableView: UITableViewDelegate {
    
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
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ingredientsPrepTableViewCell")
        cell.backgroundColor = .yellow
        let ingredient = self.recipe?.ingredients?[indexPath.row]
        cell.textLabel?.text = ingredient?.name
        return cell
    }
    
}


class IngredientsTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    let label = UILabel()
    let checkMark = UIImageView()
    let amount = UILabel()
    let measure = UILabel()
    let ingredientImg = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
