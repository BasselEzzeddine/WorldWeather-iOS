//
//  WeatherViewController.swift
//  WorldWeather
//
//  Created by Bassel Ezzeddine on 14/09/2018.
//  Copyright © 2018 Bassel Ezzeddine. All rights reserved.
//

import UIKit

protocol WeatherViewControllerIn {
    func displayWeatherInfo(viewModel: WeatherModel.Fetch.ViewModel)
}

protocol WeatherViewControllerOut {
    func fetchWeatherInfo(request: WeatherModel.Fetch.Request)
}

class WeatherViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var label_low: UILabel!
    @IBOutlet weak var label_high: UILabel!
    @IBOutlet weak var imageView_weather: UIImageView!
    @IBOutlet weak var label_current: UILabel!
    @IBOutlet weak var label_visibility: UILabel!
    @IBOutlet weak var label_pressure: UILabel!
    @IBOutlet weak var label_city: UILabel!
    
    // MARK: - Properties
    var output: WeatherViewControllerOut?
    var city = ""
    var woeid = ""
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCity()
        callFetchWeatherInfo()
    }
    
    // MARK: - Methods
    private func displayCity() {
        label_city.text = city
    }
    
    private func callFetchWeatherInfo() {
        let request = WeatherModel.Fetch.Request(woeid: woeid)
        output?.fetchWeatherInfo(request: request)
    }
}

// MARK: - WeatherInteractorIn
extension WeatherViewController: WeatherViewControllerIn {
    func displayWeatherInfo(viewModel: WeatherModel.Fetch.ViewModel) {
        label_low.text = viewModel.low
        label_high.text = viewModel.high
        imageView_weather.image = viewModel.image
        label_current.text = viewModel.current
        label_visibility.text = viewModel.visibility
        label_pressure.text = viewModel.pressure
    }
}
