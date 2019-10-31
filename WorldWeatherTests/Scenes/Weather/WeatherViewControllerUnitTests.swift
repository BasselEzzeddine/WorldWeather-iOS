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
        setupSut()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Methods
    func setupSut() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        sut = storyboard.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController
        UIApplication.shared.keyWindow?.rootViewController = sut
    }
    
    // MARK: - Spies
    class InteractorSpy: WeatherInteractorProviding {
        var fetchWeatherInfoWasCalled = false
        var fetchWeatherInfoRequest: WeatherModel.Fetch.Request?
        
        func fetchWeatherInfo(_ request: WeatherModel.Fetch.Request) {
            fetchWeatherInfoWasCalled = true
            fetchWeatherInfoRequest = request
        }
    }
    
    // MARK: - Tests
    func testWhenViewLoads_displaysCorrectCity() {
        // Given
        sut.city = City(name: "Paris", woeid: "12345")
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertEqual(sut.label_city.text, "Paris")
    }
    
    func testWhenViewLoads_callsFetchWeatherInfoInOutput_withCorrectData() {
        // Given
        let interactorSpy = InteractorSpy()
        sut.interactor = interactorSpy
        
        sut.city = City(name: "Paris", woeid: "12345")
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(interactorSpy.fetchWeatherInfoWasCalled)
        
        let request = interactorSpy.fetchWeatherInfoRequest
        XCTAssertEqual(request?.woeid, "12345")
    }
    
    func testCallingDisplayWeatherInfo_displaysCorrectWeatherInfo_andHidesActivityIndicator() {
        // When
        let sunImage = UIImage(named: "sun")!
        let viewModel = WeatherModel.Fetch.ViewModel.Success(low: "15°", high: "27°", image: sunImage, current: "19°", visibility: "10 km", pressure: "1000 hPa")
        sut.displayWeatherInfo(viewModel)
        
        // Then
        XCTAssertEqual(sut.label_low.text, "15°")
        XCTAssertEqual(sut.label_high.text, "27°")
        XCTAssertEqual(sut.imageView_weather.image, sunImage)
        XCTAssertEqual(sut.label_current.text, "19°")
        XCTAssertEqual(sut.label_visibility.text, "10 km")
        XCTAssertEqual(sut.label_pressure.text, "1000 hPa")
        
        XCTAssertTrue(sut.activityIndicator.isHidden)
    }
    
    func testCallingDisplayErrorMessage_displaysCorrectErrorMessage_andHidesActivityIndicator() {
        // When
        let viewModel = WeatherModel.Fetch.ViewModel.Failure(message: "My error message")
        sut.displayErrorMessage(viewModel)
        
        // Then
        XCTAssertTrue(sut.presentedViewController is UIAlertController)
        XCTAssertEqual((sut.presentedViewController as! UIAlertController).message, "My error message")
        
        XCTAssertTrue(sut.activityIndicator.isHidden)
    }
}
