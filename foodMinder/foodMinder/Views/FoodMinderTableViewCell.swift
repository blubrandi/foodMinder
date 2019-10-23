//
//  FoodMinderTableViewCell.swift
//  foodMinder
//
//  Created by Brandi on 10/23/19.
//  Copyright © 2019 Brandi. All rights reserved.
//

import UIKit

class FoodMinderTableViewCell: UITableViewCell {

    @IBOutlet weak var foodMinderTextLabel: UILabel!
    
    var foodMinder: FoodMinder? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let foodMinder = foodMinder else { return }
        
        foodMinderTextLabel.text = foodMinder.body
    }

}
