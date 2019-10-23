//
//  FoodMinderViewController.swift
//  foodMinder
//
//  Created by Brandi on 10/23/19.
//  Copyright © 2019 Brandi. All rights reserved.
//

import UIKit

class FoodMinderViewController: UIViewController {
    
    let foodMinderPersisitentController = FoodMinderPersistentController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        tableView.reloadData()
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Navigation

       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ToAddFoodMinderSegue" {
                if let addFoodMinderVC = segue.destination as? AddFoodMinderViewController {
                    addFoodMinderVC.delegate = self
                }
            }
        }
}

extension FoodMinderViewController: UITableViewDataSource {
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
}

extension FoodMinderViewController: AddFoodMinderDelegate {
    func foodMinderWasAdded(_ foodMinder: FoodMinder) {
        foodMinderPersisitentController.foodMinders.append(foodMinder)
        DispatchQueue.main.async {
            self.foodMinderPersisitentController.saveToPersistentStore()
            self.tableView.reloadData()
        }
    }
}
