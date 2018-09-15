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
    
    // MARK: - Spies
    class OutputSpy: WeatherViewControllerOut {
        var fetchWeatherInfoWasCalled = false
        var fetchWeatherInfoRequest: WeatherModel.Fetch.Request?
        
        func fetchWeatherInfo(request: WeatherModel.Fetch.Request) {
            fetchWeatherInfoWasCalled = true
            fetchWeatherInfoRequest = request
        }
    }
    
    // MARK: - Tests
    func testWhenViewLoads_displaysCorrectCity() {
        // Given
        sut.city = "Paris"
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertEqual(sut.label_city.text, "Paris")
    }
    
    func testCallingDisplayWeatherInfo_displaysCorrectWeatherInfo() {
        // When
        let sunImage = UIImage(named: "sun")!
        let viewModel = WeatherModel.Fetch.ViewModel(low: "15°", high: "27°", image: sunImage, current: "19°", visibility: "10 km", pressure: "1000 hPa")
        sut.displayWeatherInfo(viewModel: viewModel)
        
        // Then
        XCTAssertEqual(sut.label_low.text, "15°")
        XCTAssertEqual(sut.label_high.text, "27°")
        XCTAssertEqual(sut.imageView_weather.image, sunImage)
        XCTAssertEqual(sut.label_current.text, "19°")
        XCTAssertEqual(sut.label_visibility.text, "10 km")
        XCTAssertEqual(sut.label_pressure.text, "1000 hPa")
    }
    
    func testWhenViewLoads_callsFetchWeatherInfoInOutput_withCorrectData() {
        // Given
        let outputSpy = OutputSpy()
        sut.output = outputSpy
        
        sut.city = "Paris"
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(outputSpy.fetchWeatherInfoWasCalled)
        
        let request = outputSpy.fetchWeatherInfoRequest
        XCTAssertEqual(request?.city, "Paris")
    }
}
