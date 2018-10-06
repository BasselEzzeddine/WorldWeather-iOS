//
//  WeatherPresenterUnitTests.swift
//  WorldWeatherTests
//
//  Created by Bassel Ezzeddine on 16/09/2018.
//  Copyright © 2018 Bassel Ezzeddine. All rights reserved.
//

import XCTest
@testable import WorldWeather

class WeatherPresenterUnitTests: XCTestCase {
    
    // MARK: - Properties
    var sut: WeatherPresenter!
    
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
        sut = WeatherPresenter()
    }
    
    // MARK: - Spies
    class OutputSpy: WeatherPresenterOut {
        var displayWeatherInfoWasCalled = false
        var displayWeatherInfoViewModel: WeatherModel.Fetch.ViewModel.Success?
        
        var displayErrorMessageWasCalled = false
        var displayErrorMessageViewModel: WeatherModel.Fetch.ViewModel.Failure?
        
        func displayWeatherInfo(viewModel: WeatherModel.Fetch.ViewModel.Success) {
            displayWeatherInfoWasCalled = true
            displayWeatherInfoViewModel = viewModel
        }
        
        func displayErrorMessage(viewModel: WeatherModel.Fetch.ViewModel.Failure) {
            displayErrorMessageWasCalled = true
            displayErrorMessageViewModel = viewModel
        }
    }
    
    // MARK: - Tests
    func testCallingPresentWeatherInfo_callsDisplayWeatherInfo_withCorrectData() {
        // Given
        let outputSpy = OutputSpy()
        sut.output = outputSpy
        
        // When
        let sunImage = UIImage(named: "sun")!
        let response = WeatherModel.Fetch.Response(low: 15.333, high: 25.333, image: sunImage, current: 20.333, visibility: 10.333, pressure: 1000.333)
        sut.presentWeatherInfo(response: response)
        
        // Then
        XCTAssertTrue(outputSpy.displayWeatherInfoWasCalled)
        
        let viewModel = outputSpy.displayWeatherInfoViewModel
        XCTAssertEqual(viewModel?.low, "15°")
        XCTAssertEqual(viewModel?.high, "25°")
        XCTAssertEqual(viewModel?.image, sunImage)
        XCTAssertEqual(viewModel?.current, "20°")
        XCTAssertEqual(viewModel?.visibility, "10 km")
        XCTAssertEqual(viewModel?.pressure, "1000 hPa")
    }
    
    func testCallingPresentError_callsDisplayErrorMessage_withCorrectData() {
        // Given
        let outputSpy = OutputSpy()
        sut.output = outputSpy
        
        // When
        sut.presentError()
        
        // Then
        XCTAssertTrue(outputSpy.displayErrorMessageWasCalled)
        
        let viewModel = outputSpy.displayErrorMessageViewModel
        XCTAssertEqual(viewModel?.message, "An error has occurred, please try again later.")
    }
}
