//
//  CitiesViewController.swift
//  WorldWeather
//
//  Created by Bassel Ezzeddine on 12/09/2018.
//  Copyright © 2018 Bassel Ezzeddine. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private let cityList = ["Gothenburg", "Stockholm", "Mountain View", "London", "New York", "Berlin"]
    private let woeidList = ["890869", "906057", "2455920", "44418", "2459115", "638242"]
    private var selectedCity = ""
    private var selectedWoeid = ""
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // MARK: - Methods
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CityCell")
    }
    
    private func getCityCellAtIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        cell.backgroundColor = UIColor.black
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.textColor = UIColor.white
        let city = cityList[indexPath.row]
        cell.textLabel?.text = city
        return cell
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "Cities-Weather-Segue":
            let weatherViewController = segue.destination as? WeatherViewController
            weatherViewController?.city = selectedCity
            weatherViewController?.woeid = selectedWoeid
        default:
            break
        }
    }
}

// MARK: - UITableViewDataSource
extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getCityCellAtIndexPath(indexPath)
    }
}

// MARK: - UITableViewDelegate
extension CitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedCity = cityList[indexPath.row]
        selectedWoeid = woeidList[indexPath.row]
        performSegue(withIdentifier: "Cities-Weather-Segue", sender: self)
    }
}
