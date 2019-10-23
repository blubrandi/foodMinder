//
//  AddFoodMinderViewController.swift
//  foodMinder
//
//  Created by Brandi on 10/23/19.
//  Copyright © 2019 Brandi. All rights reserved.
//

import UIKit
import UserNotifications

protocol AddFoodMinderDelegate {
    func foodMinderWasAdded(_ foodMinder: FoodMinder)
}

class AddFoodMinderViewController: UIViewController {
    
    @IBOutlet weak var foodMinderTitle: UITextField!
    @IBOutlet weak var foodMinderDatePicker: UIDatePicker!
    
    var delegate: AddFoodMinderDelegate?
    
    @IBAction func saveFoodMinderTapped(_ sender: Any) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
                DispatchQueue.main.async {
                if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                    let time = self.foodMinderDatePicker.date.timeIntervalSinceNow
                    
                    if time > 0 {
                        
                        let notificationContent = UNMutableNotificationContent()
                        guard let foodMinderTitle = self.foodMinderTitle.text else { return }
                        
                        notificationContent.body = foodMinderTitle
                        notificationContent.title = "foodMinder"
                        notificationContent.sound = UNNotificationSound.default
                        
                        
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
                        let request = UNNotificationRequest(identifier: "foodMinder", content: notificationContent, trigger: trigger)
                        
                        let foodMinder = FoodMinder(title: notificationContent.title, body: notificationContent.body, completed: false)
                        self.delegate?.foodMinderWasAdded(foodMinder)
                        
                        UNUserNotificationCenter.current().add(request) { (_) in
                            DispatchQueue.main.async {
                                let alert = UIAlertController(title: "Suhweet!", message: "You set a foodMinder to eat!", preferredStyle: .alert)
                                let close = UIAlertAction(title: "Close", style: .default)
                                alert.addAction(close)
                                self.present(alert, animated: true)
                                
                                
                            }
                        }
                        
                    }
                }
                }
            }
        }
    }
    

