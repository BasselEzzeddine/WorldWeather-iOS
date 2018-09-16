//
//  WeatherPresenter.swift
//  WorldWeather
//
//  Created by Bassel Ezzeddine on 16/09/2018.
//  Copyright © 2018 Bassel Ezzeddine. All rights reserved.
//

import Foundation

protocol WeatherPresenterIn {
    func presentWeatherInfo(response: WeatherModel.Fetch.Response)
    func presentError()
}

protocol WeatherPresenterOut: class {
    func displayWeatherInfo(viewModel: WeatherModel.Fetch.ViewModel.Success)
    func displayErrorMessage(viewModel: WeatherModel.Fetch.ViewModel.Error)
}

class WeatherPresenter {
    
    // MARK: - Properties
    weak var output: WeatherPresenterOut?
}

// MARK: - WeatherPresenterIn
extension WeatherPresenter: WeatherPresenterIn {
    func presentWeatherInfo(response: WeatherModel.Fetch.Response) {
        let low = String(format: "%.f°", response.low)
        let high = String(format: "%.f°", response.high)
        let current = String(format: "%.f°", response.current)
        let visibility = String(format: "%.f km", response.visibility)
        let pressure = String(format: "%.f hPa", response.pressure)
        let viewModel = WeatherModel.Fetch.ViewModel.Success(low: low, high: high, image: response.image, current: current, visibility: visibility, pressure: pressure)
        output?.displayWeatherInfo(viewModel: viewModel)
    }
    
    func presentError() {
        let viewModel = WeatherModel.Fetch.ViewModel.Error(message: "An error has occurred, please try again later.")
        output?.displayErrorMessage(viewModel: viewModel)
    }
}
