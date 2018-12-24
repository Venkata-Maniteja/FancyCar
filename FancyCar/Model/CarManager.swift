//
//  CarManager.swift
//  FancyCar
//
//  Created by Venkata on 2018-12-20.
//  Copyright © 2018 Keystroke. All rights reserved.
//

import UIKit
import RealmSwift


class CarManager {
    
    typealias CompletionHandler = (_ success:Bool) -> Void

    
    static let shared = CarManager()
    weak var delegate: CarDelegate?
    
    
    func getCars(sortBy:String?) -> [RLMCar]{
        let realm = try! Realm()
        print(realm.configuration.fileURL?.absoluteString ?? "no file path")
        
        var res : Results<RLMCar>?
        var cars = [RLMCar]()
        if let sortBy = sortBy{
             res =  realm.objects(RLMCar.self).sorted(byKeyPath: sortBy, ascending: true)
        }else{
            res =  realm.objects(RLMCar.self)
        }
        
        if let res = res{
            for car in res{
                cars.append(car)
            }
        }
        return cars
    }

    
    func getCarsFromJSON() {
        
        if let path = Bundle.main.path(forResource: "cars", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try! JSONDecoder().decode([Car].self, from: data)
                addCarsToDB(cars: jsonResult)
            } catch {
                print("cannot get cars at this moment")
            }
        }
       
    }
    
    
    //I am not storing the JSON in a variable because , I have to call the GET/availability api eveytime to know the status of the car
    func isCarAvailable(rlmCar : RLMCar, completion:CompletionHandler){
        
        if let path = Bundle.main.path(forResource: "available", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [[String:String]]{
                    // do stuff
                    let car = jsonResult.filter { $0["id"] == rlmCar.carID}.first
                    
                    if let available = car?["available"]{
                        
                        rlmCar.available = available
                        completion(true)
                    }
                }
               
            } catch {
                print("cannot get cars at this moment")
            }
        }
      
    }
    
    func addCarsToDB(cars:[Car]){
        let realm = try! Realm()
        
        for car in cars{
            let realmCar = RLMCar(car: car)
            try! realm.write {
                realm.add(realmCar)
                isCarAvailable(rlmCar: realmCar,completion: { success in
                    //delegate?.carsUpdateInProgress(rlmCar:realmCar)
                })
            }
        }
        
        delegate?.carsUpdated()
       
    }
    
    

}
