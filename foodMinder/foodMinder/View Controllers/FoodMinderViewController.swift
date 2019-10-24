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
    
    override func viewDidLoad() {
        super.viewDidLoad()

}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let foodMinder = self.foodMinderPersisitentController.foodMinders[indexPath.row]
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [foodMinder.identifier])
            self.foodMinderPersisitentController.foodMinders.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            foodMinderPersisitentController.saveToPersistentStore()
            updateViews()
            
//            guard let foodMinderIndex = foodMinderPersisitentController.foodMinders.firstIndex(of: foodMinder) else { return }
//            foodMinderPersisitentController.foodMinders.remove(at: foodMinderIndex)
//            foodMinderPersisitentController.saveToPersistentStore()
//            self.foodMinderPersisitentController.foodMinders.remove(at: foodMinder)
            print("All the remove stuff ran")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodMinderPersisitentController.foodMinders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "foodMinderCell", for: indexPath) as?
            FoodMinderTableViewCell else { return UITableViewCell() }
        
        let foodMinder = foodMinderPersisitentController.foodMinders[indexPath.row]
        cell.foodMinder = foodMinder
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToAddFoodMinderSegue" {
            if let addFoodMinderVC = segue.destination as? AddFoodMinderViewController {
                addFoodMinderVC.delegate = self
            }
        } else if segue.identifier == "ToFoodMinderUpdateSegue" {
            if let editFoodMinderVC = segue.destination as? UpdateFoodMinderViewController {
                guard let indexPath = tableView.indexPathForSelectedRow else { return }
                editFoodMinderVC.foodMinder = foodMinderPersisitentController.foodMinders[indexPath.row]
                
                
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


