//
//  RawWeatherInfo.swift
//  WorldWeather
//
//  Created by Bassel Ezzeddine on 15/09/2018.
//  Copyright © 2018 Bassel Ezzeddine. All rights reserved.
//

import Foundation

struct RawWeatherInfo: Decodable {
    let dayWeatherList: [DayWeather]
    
    struct DayWeather: Decodable {
        let id: Int
        let weather_state_name: String
        let weather_state_abbr: String
        let wind_direction_compass: String
        let created: String
        let applicable_date: Date
        let min_temp: Float
        let max_temp: Float
        let the_temp: Float
        let wind_speed: Float
        let wind_direction: Float
        let air_pressure: Float
        let humidity: Float
        let visibility: Float
        let predictability: Float
    }
    
    enum CodingKeys: String, CodingKey {
        case dayWeatherList = "consolidated_weather"
    }
}
