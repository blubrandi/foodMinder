//
//  UpdateFoodMinderViewController.swift
//  foodMinder
//
//  Created by Brandi on 10/24/19.
//  Copyright © 2019 Brandi. All rights reserved.
//

import UIKit

class UpdateFoodMinderViewController: UIViewController {
    
    let foodMinderPersistentController = FoodMinderPersistentController()
    var foodMinder: FoodMinder?

    override func viewDidLoad() {
        super.viewDidLoad()
        foodMinderTitle.text = foodMinder?.title
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var foodMinderTitle: UITextField!
    @IBOutlet weak var foodMinderDate: UIDatePicker!
   
    @IBOutlet weak var activeSwtich: UISwitch!
    
    @IBAction func updateFoodMinderButton(_ sender: Any) {
        
    }
        
    @IBAction func isActiveSwitch(_ sender: Any) {
        if activeSwtich.isOn {
            foodMinder?.isActive = true
        } else {
            foodMinder?.isActive = false
        }
        foodMinderPersistentController.saveToPersistentStore()
    }
}
