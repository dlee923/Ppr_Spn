//
//  CompiledIngredientsList.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/17/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class CompiledIngredientsList: UITableView, UITableViewDelegate, UITableViewDataSource {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.setup()
    }
    
    private func setup() {
        self.backgroundColor = .red
        self.registerCells()
        self.delegate = self
        self.dataSource = self
    }
    
    private func registerCells() {
        self.register(UINib(nibName: "\(CompiledIngredientsCell.self)", bundle: .main), forCellReuseIdentifier: "compiledIngredients")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "compiledIngredients", for: indexPath) as? CompiledIngredientsCell {
            return cell
        } else {
            return UITableViewCell()
        }
    }

}
