//
//  CityWeatherDelegate.swift
//  PrevisaoDoTempo
//
//  Created by Ricardo Gehrke Filho on 05/02/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

protocol CityWeatherDelegate
{
    func showActivityIndicator()
    
    func hideActivityIndicator()
    
    func showWeatherForCity(weather: CityWeather)
}