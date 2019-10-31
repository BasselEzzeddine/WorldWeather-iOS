//
//  WeatherInteractor.swift
//  WorldWeather
//
//  Created by Bassel Ezzeddine on 15/09/2018.
//  Copyright © 2018 Bassel Ezzeddine. All rights reserved.
//

import UIKit

protocol WeatherInteractorProviding {
    func fetchWeatherInfo(_ request: WeatherModel.Fetch.Request)
}

class WeatherInteractor {
    
    // MARK: - Properties
    var presenter: WeatherPresenterProviding?
    var weatherWorker: WeatherWorker?
    
    // MARK: - Methods
    private func handleFetchWeatherInfoResponseFromWorker(_ rawWeatherInfo: RawWeatherInfo?, _ success: Bool) {
        if success, let rawWeatherInfo = rawWeatherInfo, let tommorowWeather = getTomorrowWeather(rawWeatherInfo) {
            weatherWorker?.fetchWeatherIcon(iconName: tommorowWeather.weather_state_abbr, completionHandler: { [weak self]
                (icon: UIImage?) in
                DispatchQueue.main.async {
                    guard let response = self?.createFetchResponse(tommorowWeather, icon) else {
                        self?.presenter?.presentError()
                        return
                    }
                    self?.presenter?.presentWeatherInfo(response)
                }
            })
        } else {
            DispatchQueue.main.async {
                self.presenter?.presentError()
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

// MARK: - WeatherInteractorProviding
extension WeatherInteractor: WeatherInteractorProviding {
    func fetchWeatherInfo(_ request: WeatherModel.Fetch.Request) {
        weatherWorker?.fetchWeatherInfo(woeid: request.woeid, completionHandler: { [weak self]
            (rawWeatherInfo: RawWeatherInfo?, success: Bool) in
            self?.handleFetchWeatherInfoResponseFromWorker(rawWeatherInfo, success)
        })
    }
}
