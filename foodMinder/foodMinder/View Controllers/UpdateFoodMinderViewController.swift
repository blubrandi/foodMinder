////
////  UpdateFoodMinderViewController.swift
////  foodMinder
////
////  Created by Brandi on 10/24/19.
////  Copyright © 2019 Brandi. All rights reserved.
////
//
//import UIKit
//
//class UpdateFoodMinderViewController: UIViewController {
//    
//    let foodMinderPersistentController = FoodMinderPersistentController()
//    var foodMinder: FoodMinder?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
////        updateViews()
//        // Do any additional setup after loading the view.
//    }
//    
//    @IBOutlet weak var foodMinderTitle: UITextField!
//    @IBOutlet weak var activeSwtich: UISwitch!
//
//    
//    @IBAction func updateFoodMinderButton(_ sender: Any) {
//        
//        guard case foodMinderTitle.text = foodMinder!.title else { return }
//        
//        if let foodMinder = foodMinder {
//            foodMinderPersistentController.update(foodMinder: foodMinder, withTitle: foodMinder.title)
//        }
//        
//        foodMinderPersistentController.saveToPersistentStore()
//        
//        navigationController?.popViewController(animated: true)
//    }
//        
//    @IBOutlet weak var backToFoodMinderVC: UINavigationItem!
//    @IBAction func isActiveSwitch(_ sender: Any) {
//        if activeSwtich.isOn {
//            foodMinder?.isActive = true
//        } else {
//            foodMinder?.isActive = false
//        }
//        
//    }
//}
