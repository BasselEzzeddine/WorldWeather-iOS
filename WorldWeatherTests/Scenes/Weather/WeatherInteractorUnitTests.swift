//
//  WeatherInteractorUnitTests.swift
//  WorldWeatherTests
//
//  Created by Bassel Ezzeddine on 15/09/2018.
//  Copyright © 2018 Bassel Ezzeddine. All rights reserved.
//

import XCTest
@testable import WorldWeather

class WeatherInteractorUnitTests: XCTestCase {
    
    // MARK: - Properties
    var sut: WeatherInteractor!
    
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
        sut = WeatherInteractor()
    }
    
    // MARK: - Spies
    class OutputSpy: WeatherInteractorOut {
        var presentWeatherInfoWasCalled = false
        var presentWeatherInfoResponse: WeatherModel.Fetch.Response?
        
        var presentErrorWasCalled = false
        
        func presentWeatherInfo(_ response: WeatherModel.Fetch.Response) {
            presentWeatherInfoWasCalled = true
            presentWeatherInfoResponse = response
        }
        
        func presentError() {
            presentErrorWasCalled = true
        }
    }
    
    class WeatherWorkerSpy: WeatherWorker {
        var rawWeatherInfoToBeReturned: RawWeatherInfo?
        var successToBeReturned = false
        
        override func fetchWeatherInfo(woeid: String, completionHandler: @escaping (RawWeatherInfo?, Bool) -> Void) {
            completionHandler(rawWeatherInfoToBeReturned, successToBeReturned)
        }
        
        override func fetchWeatherIcon(iconName: String, completionHandler: @escaping (UIImage?) -> Void) {
            completionHandler(UIImage(named: "sun"))
        }
    }
    
    // MARK: - Tests
    func testCallingFetchWeatherInfo_callsPresentWeatherInfoInOutput_withCorrectData_whenHavingSuccess() {
        // Given
        let outputSpy = OutputSpy()
        sut.output = outputSpy
        
        let weatherWorkerSpy = WeatherWorkerSpy()
        sut.weatherWorker = weatherWorkerSpy
        
        // When
        let dayWeather1 = RawWeatherInfo.DayWeather(id: 1, weather_state_name: "", weather_state_abbr: "", wind_direction_compass: "", created: "", applicable_date: Date(), min_temp: 0, max_temp: 0, the_temp: 0, wind_speed: 0, wind_direction: 0, air_pressure: 0, humidity: 0, visibility: 0, predictability: 0)
        let dayWeather2 = RawWeatherInfo.DayWeather(id: 2, weather_state_name: "Heavy Rain", weather_state_abbr: "hr", wind_direction_compass: "WSW", created: "", applicable_date: Date().tomorrow(), min_temp: 20, max_temp: 30, the_temp: 25, wind_speed: 50, wind_direction: 300, air_pressure: 1000, humidity: 10, visibility: 30, predictability: 70)
        let dayWeather3 = RawWeatherInfo.DayWeather(id: 3, weather_state_name: "", weather_state_abbr: "", wind_direction_compass: "", created: "", applicable_date: Date(), min_temp: 0, max_temp: 0, the_temp: 0, wind_speed: 0, wind_direction: 0, air_pressure: 0, humidity: 0, visibility: 0, predictability: 0)
        weatherWorkerSpy.rawWeatherInfoToBeReturned = RawWeatherInfo(dayWeatherList: [dayWeather1, dayWeather2, dayWeather3])
        weatherWorkerSpy.successToBeReturned = true
        
        let request = WeatherModel.Fetch.Request(woeid: "12345")
        sut.fetchWeatherInfo(request)
        
        RunLoop.current.run(mode: RunLoop.Mode.default, before: Date(timeIntervalSinceNow: 1)) // Wait a little
        
        // Then
        XCTAssertTrue(outputSpy.presentWeatherInfoWasCalled)
        
        let response = outputSpy.presentWeatherInfoResponse
        XCTAssertEqual(response?.low, 20)
        XCTAssertEqual(response?.high, 30)
        XCTAssertEqual(response?.current, 25)
        XCTAssertEqual(response?.image, UIImage(named: "sun"))
        XCTAssertEqual(response?.visibility, 30)
        XCTAssertEqual(response?.pressure, 1000)
    }
    
    func testCallingFetchWeatherInfo_callsPresentErrorInOutput_whenHavingFailure() {
        // Given
        let outputSpy = OutputSpy()
        sut.output = outputSpy
        
        let weatherWorkerSpy = WeatherWorkerSpy()
        sut.weatherWorker = weatherWorkerSpy
        
        // When
        weatherWorkerSpy.successToBeReturned = false
        
        let request = WeatherModel.Fetch.Request(woeid: "12345")
        sut.fetchWeatherInfo(request)
        
        RunLoop.current.run(mode: RunLoop.Mode.default, before: Date(timeIntervalSinceNow: 1)) // Wait a little
        
        // Then
        XCTAssertTrue(outputSpy.presentErrorWasCalled)
    }
}
