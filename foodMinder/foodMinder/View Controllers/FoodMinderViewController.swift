//
//  FoodMinderViewController.swift
//  foodMinder
//
//  Created by Brandi on 10/23/19.
//  Copyright © 2019 Brandi. All rights reserved.
//

import UIKit

class FoodMinderViewController: UIViewController, UITableViewDataSource {
    
    let foodMinderPersisitentController = FoodMinderPersistentController()
    
    //MARK:  View Properties
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:  Table & Table Cell Properties
    
    func togglefoodMinderAt(cell: FoodMinderTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        let foodMinder = foodMinderAt(indexPath: indexPath)
        foodMinderPersisitentController.toogleActive(for: foodMinder)
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [foodMinder.identifier])
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let foodMinder = self.foodMinderPersisitentController.foodMinders[indexPath.row]
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [foodMinder.identifier])
            self.foodMinderPersisitentController.foodMinders.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            foodMinderPersisitentController.saveToPersistentStore()
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return foodMinderPersisitentController.activeFoodMinders.count
        } else {
            return foodMinderPersisitentController.inactiveFoodMinders.count
        }
    }
    
    func foodMinderAt(indexPath: IndexPath) -> FoodMinder {
        if indexPath.section == 0 {
            return foodMinderPersisitentController.activeFoodMinders[indexPath.row]
        } else {
            return foodMinderPersisitentController.inactiveFoodMinders[indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            guard foodMinderPersisitentController.activeFoodMinders.count > 0 else { return nil }
            return "Active foodMinders"
        } else {
            guard foodMinderPersisitentController.inactiveFoodMinders.count > 0 else { return nil }
            return "Inactive foodMinders"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "foodMinderCell", for: indexPath) as?
            FoodMinderTableViewCell else { return UITableViewCell() }
        
        let foodMinder = foodMinderPersisitentController.foodMinders[indexPath.row]
        cell.foodMinder = foodMinder
        
        return cell
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToAddFoodMinderSegue" {
            if let addFoodMinderVC = segue.destination as? AddFoodMinderViewController {
                addFoodMinderVC.delegate = self
            }
        }
    }
}

//Mark:  Delegate

extension FoodMinderViewController: AddFoodMinderDelegate {
    func foodMinderWasAdded(_ foodMinder: FoodMinder) {
        foodMinderPersisitentController.foodMinders.append(foodMinder)
        DispatchQueue.main.async {
            self.foodMinderPersisitentController.saveToPersistentStore()
            self.tableView.reloadData()
        }
    }
}


