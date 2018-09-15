//
//  WeatherModel.swift
//  WorldWeather
//
//  Created by Bassel Ezzeddine on 15/09/2018.
//  Copyright © 2018 Bassel Ezzeddine. All rights reserved.
//

import UIKit

enum WeatherModel {
    
    enum Fetch {
        struct Request {
            let woeid: String
        }
        
        struct Response {
        }
        
        struct ViewModel {
            let low: String
            let high: String
            let image: UIImage
            let current: String
            let visibility: String
            let pressure: String
        }
    }
}
