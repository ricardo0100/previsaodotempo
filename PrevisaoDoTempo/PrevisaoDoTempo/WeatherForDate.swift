//
//  WeatherForDate.swift
//  PrevisaoDoTempo
//
//  Created by Ricardo Gehrke Filho on 06/02/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

class WeatherForDate {
    
    var date: NSDate
    var status: String
    var max: Int
    var min: Int
    var uvi: Float
    
    init(date: NSDate, status: String, max: Int, min: Int, uvi: Float) {
        self.date = date
        self.status = status
        self.max = max
        self.min = min
        self.uvi = uvi
    }
}