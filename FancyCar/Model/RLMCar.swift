//
//  RLMCar.swift
//  FancyCar
//
//  Created by Venkata on 2018-12-21.
//  Copyright © 2018 Keystroke. All rights reserved.
//

import UIKit
import RealmSwift

class RLMCar: Object {
    @objc dynamic var name = ""
    @objc dynamic var make = ""
    @objc dynamic var model = ""
    @objc dynamic var year = ""
    @objc dynamic var icon = ""
    @objc dynamic var carID = ""
    @objc dynamic var available = ""
    @objc dynamic var pk = 0
    
    func getLastRowPk() -> Int{
        let realm = try! Realm()
        if let maxValue =  realm.objects(RLMCar.self).max(ofProperty: "pk") as Int?{
            return maxValue
        }
        return 0
    }
    
    override static func primaryKey() -> String? {
        return "pk"
    }
    
    convenience init(car:Car) {
        self.init()
        
        name = car.carName
        make = car.make
        model = car.model
        year = car.year
        icon = car.icon
        carID = car.carID
        pk = getLastRowPk() + 1

        print(pk)
    }
    
    
}
