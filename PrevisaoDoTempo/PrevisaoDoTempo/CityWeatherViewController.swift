//
//  CityWeatherViewController.swift
//  PrevisaoDoTempo
//
//  Created by Ricardo Gehrke Filho on 05/02/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class CityWeatherViewController: UIViewController {

    var city: City?
    
    @IBOutlet weak var cityName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityName.text = self.city!.name
    }
    
    internal func showWeatherForCityWithId(city: City) {
        self.city = city
    }
    
}
