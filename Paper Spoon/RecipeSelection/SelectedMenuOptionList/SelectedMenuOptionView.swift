//
//  SelectedMenuOptionView.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 2/9/20.
//  Copyright © 2020 DLEE. All rights reserved.
//

import UIKit

class SelectedMenuOptionView: UIView {
    
    convenience init(frame: CGRect, selectedMenuOptions: [MenuOption]) {
        self.init(frame: frame)
        self.selectedMenuOptionList.selectedMenuOptions = selectedMenuOptions
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSelectedMenuOptionList()
    }
    
    var selectedMenuOptionList = SelectedMenuOptionList(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private func addSelectedMenuOptionList() {
        self.addSubview(selectedMenuOptionList)
        
        self.selectedMenuOptionList.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.topAnchor),
            self.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
            self.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
