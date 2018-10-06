//
//  WeatherConfigurator.swift
//  WorldWeather
//
//  Created by Bassel Ezzeddine on 16/09/2018.
//  Copyright © 2018 Bassel Ezzeddine. All rights reserved.
//

import Foundation

extension WeatherViewController: WeatherPresenterOut {
}

extension WeatherInteractor: WeatherViewControllerOut {
}

extension WeatherPresenter: WeatherInteractorOut {
}

class WeatherConfigurator {
    
    // MARK: - Properties
    static let sharedInstance = WeatherConfigurator()
    
    // MARK: - Methods
    func configure(viewController: WeatherViewController) {
        let interactor = WeatherInteractor()
        viewController.output = interactor
        
        let presenter = WeatherPresenter()
        presenter.output = viewController
        
        interactor.output = presenter
        interactor.weatherWorker = WeatherWorker()
    }
}
