//
//  FoodMinder.swift
//  foodMinder
//
//  Created by Brandi on 10/23/19.
//  Copyright © 2019 Brandi. All rights reserved.
//

import Foundation

struct FoodMinder: Codable, Equatable {
    
    var title: String
    var body: String
    let identifier: String = UUID().uuidString
    var isActive: Bool
    
    init(title: String, body: String, isActive: Bool = true) {
        self.title = title
        self.body = body
        self.isActive = isActive
    }
}
