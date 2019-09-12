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
        self.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "compiledIngredientsHeader")
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            // section for ingredients list
            if let cell = tableView.dequeueReusableCell(withIdentifier: "compiledIngredients", for: indexPath) as? CompiledIngredientsCell {
                cell.ingredient = self.compiledIngredients[indexPath.row]
                return cell
            } else {
            return UITableViewCell()
            }
        case 1:
            // section for shopping bag
            if let cell = tableView.dequeueReusableCell(withIdentifier: "compiledIngredients", for: indexPath) as? CompiledIngredientsCell {
                cell.ingredient = self.purchasedIngredients[indexPath.row]
                cell.backgroundColor = UIColor.color6
                return cell
            } else {
                return UITableViewCell()
            }
        default: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = UITableViewHeaderFooterView(reuseIdentifier: "compiledIngredientsHeader")
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
        label.font = UIFont.fontSunflower?.withSize(20)
        label.backgroundColor = UIColor.themeColor1
        
        switch section {
        case 0:
            label.text = "Ingredient List"
        case 1:
            label.text = "Shopping Cart"
        default: break
        }
        cell.addSubview(label)
        
        return cell
    }

}

extension CompiledIngredientsList: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            print("purchased!")
            self.swapIngredient(pullOutfrom: &self.compiledIngredients, insertInto: &self.purchasedIngredients, index: indexPath.row)

            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .bottom)
            tableView.insertRows(at: [IndexPath(row: self.purchasedIngredients.count - 1, section: 1)], with: .top)
            tableView.endUpdates()
        case 1:
            print("unpurchased!")
            self.swapIngredient(pullOutfrom: &self.purchasedIngredients, insertInto: &self.compiledIngredients, index: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .bottom)
            tableView.insertRows(at: [IndexPath(row: self.compiledIngredients.count - 1, section: 0)], with: .top)
            tableView.endUpdates()
        default: break
        }
    }
    
    func swapIngredient(pullOutfrom originList: inout [Ingredients], insertInto destinationList: inout [Ingredients], index: Int) {
        // create ingredient variable
        let ingredientToSwap = originList[index]
        // insert into destination list
        destinationList.append(ingredientToSwap)
        // remove from origin list
        originList.remove(at: index)
    }
    
}
