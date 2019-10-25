//
//  FoodMinderPersistentController.swift
//  foodMinder
//
//  Created by Brandi on 10/23/19.
//  Copyright © 2019 Brandi. All rights reserved.
//

import Foundation

class FoodMinderPersistentController {
    
    var foodMinders: [FoodMinder] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    //MARK:  foodMinder isActive & Remove Properties
    
    var activeFoodMinders: [FoodMinder] {
        return foodMinders.filter({ $0.isActive })
    }
    var inactiveFoodMinders: [FoodMinder] {
        return foodMinders.filter({ $0.isActive == false })
    }
    
    func toogleActive(for foodMinder: FoodMinder) {
        
        guard let index = foodMinders.firstIndex(of: foodMinder) else { return }
        foodMinders[index].isActive = !foodMinders[index].isActive
        
        saveToPersistentStore()
    }
    
    func removeFoodMinder(foodMinder: FoodMinder) {
        guard let index = foodMinders.firstIndex(of: foodMinder) else { return }
        foodMinders.remove(at: index)
        
        saveToPersistentStore()
    }
    
    //MARK:  Persistence
    
    func loadFromPersistentStore() {
        do {
            guard let fileURL = foodMinderURL else { return }
            let foodMinderData = try Data(contentsOf: fileURL)
            let pListDecoder = PropertyListDecoder()
            self.foodMinders = try pListDecoder.decode([FoodMinder].self, from: foodMinderData)
        } catch {
            print("There was an error retreiving your foodMinders: \(error)")
        }
    }
    
    func saveToPersistentStore() {
        
        let plistEncoder = PropertyListEncoder()
        
        do  {
            let foodMinderData = try plistEncoder.encode(foodMinders)
            guard let fileURL = foodMinderURL else { return }
            try foodMinderData.write(to: fileURL)
        } catch {
            print("There was an error saving your foodMinders: \(error)")
        }
    }
    
    
    private var foodMinderURL: URL? {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileName = "foodMinder.plist"
        
        return documentDirectory?.appendingPathComponent(fileName)
    }
}
