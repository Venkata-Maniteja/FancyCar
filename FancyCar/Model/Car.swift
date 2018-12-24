//
//  Car.swift
//  FancyCar
//
//  Created by Venkata on 2018-12-20.
//  Copyright © 2018 Keystroke. All rights reserved.
//

import UIKit

struct Car: Codable {
   
    var carName : String
    var make : String
    var model : String
    var year : String
    var icon : String
    var carID : String
    
    enum CodingKeys : String, CodingKey{
        case carName = "name"
        case make = "make"
        case model = "model"
        case year = "year"
        case icon = "icon"
        case carID = "id"
    }
    
  
    
}

extension Car: Equatable{
    
    static func == (lhs:Car,rhs:Car) -> Bool{
        if lhs.carName == rhs.carName && lhs.make == rhs.make && lhs.model == rhs.model && lhs.year == rhs.year && lhs.icon == rhs.icon && lhs.carID == rhs.carID {
            return true
        }else{
            return false
        }
        
    }
}
