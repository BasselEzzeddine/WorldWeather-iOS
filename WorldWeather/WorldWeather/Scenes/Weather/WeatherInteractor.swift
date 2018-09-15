//
//  WeatherInteractor.swift
//  WorldWeather
//
//  Created by Bassel Ezzeddine on 15/09/2018.
//  Copyright © 2018 Bassel Ezzeddine. All rights reserved.
//

import Foundation

protocol WeatherInteractorIn {
    func fetchWeatherInfo(request: WeatherModel.Fetch.Request)
}

protocol WeatherInteractorOut {
}

class WeatherInteractor {
    
}

// MARK: - WeatherInteractorIn
extension WeatherInteractor: WeatherInteractorIn {
    func fetchWeatherInfo(request: WeatherModel.Fetch.Request) {
    }
}
