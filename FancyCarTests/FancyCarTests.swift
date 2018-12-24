//
//  FancyCarTests.swift
//  FancyCarTests
//
//  Created by Keystroke on 2018-12-20.
//  Copyright © 2018 Keystroke. All rights reserved.
//

import XCTest
@testable import FancyCar

class FancyCarTests: XCTestCase {
    
    var testCar : Car?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testCar = Car(carName: "Green River", make: "Toyoto", model: "Electric", year: "2012", icon: "icon_car_green", carID: "2")
        
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        testCar = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    //This checks if all green cars coming from JSON has same ID as the test green Car
    func testGreenCars(){
        if let path = Bundle.main.path(forResource: "cars", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try! JSONDecoder().decode([Car].self, from: data)
                for car in jsonResult{
                    if car.carName == "GreenRiver"{
                        if let testCar = testCar{
                            XCTAssertTrue(car.carID == testCar.carID)
                        }
                        
                    }
                }
            } catch {
                print("cannot get cars at this moment")
            }
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
