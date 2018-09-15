//
//  WeatherViewControllerUnitTests.swift
//  WorldWeatherTests
//
//  Created by Bassel Ezzeddine on 12/09/2018.
//  Copyright © 2018 Bassel Ezzeddine. All rights reserved.
//

import XCTest
@testable import WorldWeather

class WeatherViewControllerUnitTests: XCTestCase {
    // MARK: - Properties
    var sut: WeatherViewController!
    
    // MARK: - XCTestCase
    override func setUp() {
        super.setUp()
        setupSUT()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Methods
    func setupSUT() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        sut = storyboard.instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
        UIApplication.shared.keyWindow?.rootViewController = sut
    }
    
    // MARK: - Tests
    func testWhenViewLoads_displaysCity() {
        // Given
        sut.city = "Paris"
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertEqual(sut.label_city.text, "Paris")
    }
}
