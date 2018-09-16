//
//  Date+Extensions.swift
//  WorldWeather
//
//  Created by Bassel Ezzeddine on 15/09/2018.
//  Copyright © 2018 Bassel Ezzeddine. All rights reserved.
//

import Foundation

extension Date {
    
    func tomorrow() -> Date {
        return Calendar.current.date(byAdding: DateComponents(day: 1), to: self)!
    }
    
    func dayMonthYearString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dayMonthYear = dateFormatter.string(from: self)
        return dayMonthYear
    }
}
