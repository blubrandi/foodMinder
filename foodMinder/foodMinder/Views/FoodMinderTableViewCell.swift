//
//  FoodMinderTableViewCell.swift
//  foodMinder
//
//  Created by Brandi on 10/23/19.
//  Copyright © 2019 Brandi. All rights reserved.
//

import UIKit

class FoodMinderTableViewCell: UITableViewCell {
    
    let foodMinderPersistentController = FoodMinderPersistentController()
    var delegate: FoodMinderTableViewCellDelegate?

    @IBOutlet weak var foodMinderTextLabel: UILabel!
    @IBOutlet weak var activeSwitch: UISwitch!
    
    var foodMinder: FoodMinder? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let foodMinder = foodMinder else { return }
        
        foodMinderTextLabel.text = foodMinder.body

    }
    
    @IBAction func toggleActiveSwitch(_ sender: Any) {
        delegate?.toggleIsActiveFor(cell: self)
        
        if activeSwitch.isOn {
            foodMinder?.isActive = true
        } else {
            foodMinder?.isActive = false
        }
        print(foodMinder)
    }
    
}
