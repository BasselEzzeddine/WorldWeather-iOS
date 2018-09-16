//
//  WeatherWorker.swift
//  WorldWeather
//
//  Created by Bassel Ezzeddine on 15/09/2018.
//  Copyright © 2018 Bassel Ezzeddine. All rights reserved.
//

import UIKit

class WeatherWorker {
    
    // MARK: - Properties
    let endpoint = "https://www.metaweather.com/api"
    
    // MARK: - Methods
    func fetchWeatherInfo(woeid: String, completionHandler: @escaping(_ rawWeatherInfo: RawWeatherInfo?, _ success: Bool) -> Void) {
        let urlString = "\(endpoint)/api/location/\(woeid)"
        guard let url = URL(string: urlString) else {
            completionHandler(nil, false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = .reloadIgnoringLocalCacheData
        
        URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            if let data = data, error == nil {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
                    let rawWeatherInfo = try decoder.decode(RawWeatherInfo.self, from: data)
                    completionHandler(rawWeatherInfo, true)
                }
                catch {
                    completionHandler(nil, false)
                }
            }
            else {
                completionHandler(nil, false)
            }
        }).resume()
    }
    
    func fetchWeatherIcon(iconName: String, completionHandler: @escaping(_ icon: UIImage?) -> Void) {
        let urlString = "\(endpoint)/static/img/weather/png/64/\(iconName)"
        guard let url = URL(string: urlString) else {
            completionHandler(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = .reloadIgnoringLocalCacheData
        
        URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, error == nil {
                    let icon = UIImage(data: data)
                    completionHandler(icon)
                }
                else {
                    completionHandler(nil)
                }
            }
        }).resume()
    }
}
