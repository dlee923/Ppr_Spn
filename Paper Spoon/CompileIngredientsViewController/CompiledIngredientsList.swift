//
//  CompiledIngredientsList.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/17/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class CompiledIngredientsList: UITableView, UITableViewDataSource {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.setup()
    }
    
    private func setup() {
        self.backgroundColor = UIColor.themeColor1
        self.registerCells()
        self.delegate = self
        self.dataSource = self
    }
    
    var compiledIngredients = [Ingredients]()
    var purchasedIngredients = [Ingredients]()
    
    private func registerCells() {
        self.register(UINib(nibName: "\(CompiledIngredientsCell.self)", bundle: .main), forCellReuseIdentifier: "compiledIngredients")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.compiledIngredients.count
        case 1:
            return self.purchasedIngredients.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "compiledIngredients", for: indexPath) as? CompiledIngredientsCell {
                cell.ingredientName.text = self.compiledIngredients[indexPath.row].name
                cell.measureAmount.text = String(describing: self.compiledIngredients[indexPath.row].amount ?? 1)
                cell.measureLbl.text = self.compiledIngredients[indexPath.row].measurementType
                return cell
            } else {
            return UITableViewCell()
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "compiledIngredients", for: indexPath) as? CompiledIngredientsCell {
                cell.ingredientName.text = self.compiledIngredients[indexPath.row].name
                cell.measureAmount.text = String(describing: self.compiledIngredients[indexPath.row].amount ?? 1)
                cell.measureLbl.text = self.compiledIngredients[indexPath.row].measurementType
                return cell
            } else {
                return UITableViewCell()
            }
        default: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "compiledIngredientsHeader")
        cell.textLabel?.font = UIFont.fontSunflower?.withSize(20)
        cell.backgroundColor = UIColor.themeColor1
        switch section {
            case 0: cell.textLabel?.text = "Ingredient List"
            case 1: cell.textLabel?.text = "Shopping Cart"
            default: break
        }
        
        return cell
    }

}

extension CompiledIngredientsList: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            print("purchased!")
            self.swapIngredient(pullOutfrom: &self.compiledIngredients, insertInto: &self.purchasedIngredients, index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        case 1:
            print("unpurchased!")
            self.swapIngredient(pullOutfrom: &self.purchasedIngredients, insertInto: &self.compiledIngredients, index: indexPath.row)
        default: break
        }
    }
    
    canedit
    
    func swapIngredient(pullOutfrom originList: inout [Ingredients], insertInto destinationList: inout [Ingredients], index: Int) {
        // create ingredient variable
        let ingredientToSwap = originList[index]
        // insert into destination list
        destinationList.append(ingredientToSwap)
        // remove from origin list
        originList.remove(at: index)
    }
    
}
