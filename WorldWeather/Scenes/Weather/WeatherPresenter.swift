//
//  WeatherPresenter.swift
//  WorldWeather
//
//  Created by Bassel Ezzeddine on 16/09/2018.
//  Copyright © 2018 Bassel Ezzeddine. All rights reserved.
//

import Foundation

protocol WeatherPresenterProviding {
    func presentWeatherInfo(_ response: WeatherModel.Fetch.Response)
    func presentError()
}

class WeatherPresenter {
    
    // MARK: - Properties
    weak var viewController: WeatherViewControllerProviding?
}

// MARK: - WeatherPresenterProviding
extension WeatherPresenter: WeatherPresenterProviding {
    func presentWeatherInfo(_ response: WeatherModel.Fetch.Response) {
        let low = String(format: "%.f°", response.low)
        let high = String(format: "%.f°", response.high)
        let current = String(format: "%.f°", response.current)
        let visibility = String(format: "%.f km", response.visibility)
        let pressure = String(format: "%.f hPa", response.pressure)
        let viewModel = WeatherModel.Fetch.ViewModel.Success(low: low, high: high, image: response.image, current: current, visibility: visibility, pressure: pressure)
        viewController?.displayWeatherInfo(viewModel)
    }
    
    func presentError() {
        let viewModel = WeatherModel.Fetch.ViewModel.Failure(message: "An error has occurred, please try again later.")
        viewController?.displayErrorMessage(viewModel)
    }
}
