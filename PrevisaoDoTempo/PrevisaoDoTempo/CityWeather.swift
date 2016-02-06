//
//  Weather.swift
//  PrevisaoDoTempo
//
//  Created by Ricardo Gehrke Filho on 06/02/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

class CityWeather {
    
    var city: City
    
    var update: NSDate?
    var weatherDates: [WeatherForDate]? = []
    
    init(city: City) {
        self.city = city
    }
    
}