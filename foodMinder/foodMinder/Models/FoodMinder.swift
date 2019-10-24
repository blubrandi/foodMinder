//
//  FoodMinder.swift
//  foodMinder
//
//  Created by Brandi on 10/23/19.
//  Copyright © 2019 Brandi. All rights reserved.
//

import Foundation

struct FoodMinder: Codable, Equatable{
    
    let title: String
    let body: String
    let identifier: String = UUID().uuidString
    var isActive: Bool

}
