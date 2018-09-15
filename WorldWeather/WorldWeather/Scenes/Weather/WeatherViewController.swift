//
//  WeatherViewController.swift
//  WorldWeather
//
//  Created by Bassel Ezzeddine on 14/09/2018.
//  Copyright © 2018 Bassel Ezzeddine. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var label_low: UILabel!
    @IBOutlet weak var label_high: UILabel!
    @IBOutlet weak var imageView_weather: UIImageView!
    @IBOutlet weak var label_current: UILabel!
    @IBOutlet weak var label_city: UILabel!
    
    // MARK: - Properties
    var city = ""
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCity()
    }
    
    // MARK: - Methods
    private func displayCity() {
        label_city.text = city
    }
}
