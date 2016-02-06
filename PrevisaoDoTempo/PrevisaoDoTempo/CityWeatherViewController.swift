//
//  CityWeatherViewController.swift
//  PrevisaoDoTempo
//
//  Created by Ricardo Gehrke Filho on 05/02/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import JGProgressHUD

class CityWeatherViewController: UIViewController, CityWeatherDelegate {

    var hud: JGProgressHUD?
    
    var city: City?
    var controller = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller.detailCityWeather = self
        
        hud = JGProgressHUD(style: .Dark)
        hud!.textLabel!.text = "Buscando"
    }
    
    override func viewWillAppear(animated: Bool) {
        title = city!.name
        controller.showWeatherForCity(city!)
    }
    
    internal func showWeatherForCityWithId(city: City) {
        self.city = city
    }
    
    func showActivityIndicator() {
        hud!.showInView(self.view)
    }
    
    func hideActivityIndicator() {
        hud!.dismiss()
    }
    
    func showWeatherForCity(weather: CityWeather) {
        print(String(weather.update!.debugDescription))
    }
    
}
