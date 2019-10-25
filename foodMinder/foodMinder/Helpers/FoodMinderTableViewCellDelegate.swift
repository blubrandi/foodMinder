//
//  File.swift
//  foodMinder
//
//  Created by Brandi on 10/25/19.
//  Copyright © 2019 Brandi. All rights reserved.
//

import Foundation

protocol FoodMinderTableViewCellDelegate {
    func toggleIsActiveFor(cell: FoodMinderTableViewCell)
}
