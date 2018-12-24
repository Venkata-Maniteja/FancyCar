//
//  CarDelegate.swift
//  FancyCar
//
//  Created by Venkata on 2018-12-23.
//  Copyright © 2018 Keystroke. All rights reserved.
//

import UIKit

@objc protocol CarDelegate: class {
    @objc optional func carsUpdateInProgress(rlmCar:RLMCar) //Need to mark @objc to make optional
    func carsUpdated()
}
