//
//  MyweatherAppTests.swift
//  MyweatherAppTests
//
//  Created by admin on 4/19/17.
//  Copyright © 2017 Anuja. All rights reserved.
//

import XCTest
@testable import MyweatherApp

class MyweatherAppTests: XCTestCase {
    
    var readWeatherData:ReadWeatherData!
    
    override func setUp() {
        super.setUp()
        readWeatherData = ReadWeatherData()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetURL(){
        
        let url = readWeatherData.getURL(city: "Atlanta")
        let expectedURL:URL = NSURL(string: "http://api.openweathermap.org/data/2.5/forecast?q=Atlanta&APPID=2da3dffb466cf1848a0a1a70e314a7d2")! as URL
        XCTAssertEqual(url, expectedURL,"url Not equal")
        
        
        
    }
    
    func testGetDateAndTime(){
        
        let (date, time) = readWeatherData.splitString(str: "2017-04-05 18:00:00", separator: " " )
        let expectedDate = "2017-04-05"
        let expectedTime = "18:00:00"
        XCTAssertEqual(date, expectedDate,"date Should be equal")
        XCTAssertEqual(time, expectedTime,"time should be equal")
        
    }
    
    
    
}
