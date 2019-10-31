//
//  WeatherConfigurator.swift
//  WorldWeather
//
//  Created by Bassel Ezzeddine on 16/09/2018.
//  Copyright © 2018 Bassel Ezzeddine. All rights reserved.
//

import Foundation

class WeatherConfigurator {
    
    // MARK: - Methods
    func configure(viewController: WeatherViewController) {
        let interactor = WeatherInteractor()
        viewController.interactor = interactor
        
        let presenter = WeatherPresenter()
        presenter.viewController = viewController
        
        interactor.presenter = presenter
        interactor.weatherWorker = WeatherWorker()
    }
}
