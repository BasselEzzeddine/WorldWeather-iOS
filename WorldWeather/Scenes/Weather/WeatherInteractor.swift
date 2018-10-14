//
//  WeatherInteractor.swift
//  WorldWeather
//
//  Created by Bassel Ezzeddine on 15/09/2018.
//  Copyright © 2018 Bassel Ezzeddine. All rights reserved.
//

import UIKit

protocol WeatherInteractorIn {
    func fetchWeatherInfo(request: WeatherModel.Fetch.Request)
}

protocol WeatherInteractorOut {
    func presentWeatherInfo(response: WeatherModel.Fetch.Response)
    func presentError()
}

class WeatherInteractor {
    
    // MARK: - Properties
    var output: WeatherInteractorOut?
    var weatherWorker: WeatherWorker?
    
    // MARK: - Methods
    private func handleFetchWeatherInfoResponseFromWorker(_ rawWeatherInfo: RawWeatherInfo?, _ success: Bool) {
        if success, let rawWeatherInfo = rawWeatherInfo, let tommorowWeather = getTomorrowWeather(rawWeatherInfo) {
            weatherWorker?.fetchWeatherIcon(iconName: tommorowWeather.weather_state_abbr, completionHandler: {
                (icon: UIImage?) in
                let response = self.createFetchResponse(tommorowWeather, icon)
                DispatchQueue.main.async {
                    self.output?.presentWeatherInfo(response: response)
                }
            })
        }
        else {
            DispatchQueue.main.async {
                self.output?.presentError()
            }
        }
    }
    
    private func getTomorrowWeather(_ rawWeatherInfo: RawWeatherInfo) -> RawWeatherInfo.DayWeather? {
        let tommorowWeather = rawWeatherInfo.dayWeatherList.filter { $0.applicable_date.dayMonthYearString() == Date().tomorrow().dayMonthYearString() }.first
        return tommorowWeather
    }
    
    private func createFetchResponse(_ tommorowWeather: RawWeatherInfo.DayWeather, _ icon: UIImage?) -> WeatherModel.Fetch.Response {
        let response = WeatherModel.Fetch.Response(low: tommorowWeather.min_temp, high: tommorowWeather.max_temp, image: icon, current: tommorowWeather.the_temp, visibility: tommorowWeather.visibility, pressure: tommorowWeather.air_pressure)
        return response
    }
}

// MARK: - WeatherInteractorIn
extension WeatherInteractor: WeatherInteractorIn {
    func fetchWeatherInfo(request: WeatherModel.Fetch.Request) {
        weatherWorker?.fetchWeatherInfo(woeid: request.woeid, completionHandler: {
            (rawWeatherInfo: RawWeatherInfo?, success: Bool) in
            self.handleFetchWeatherInfoResponseFromWorker(rawWeatherInfo, success)
        })
    }
}
