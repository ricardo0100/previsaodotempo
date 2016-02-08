//
//  CityWeatherTableViewController.swift
//  PrevisaoDoTempo
//
//  Created by Ricardo Gehrke Filho on 05/02/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import JGProgressHUD
import Slash

class CityWeatherTableViewController: UITableViewController, CityWeatherDelegate {
    
    var hud: JGProgressHUD?
    
    var city: City?
    var weather: CityWeather?
    
    var controller = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller.detailCityWeather = self
        
        hud = JGProgressHUD(style: .Dark)
        hud!.textLabel!.text = "Buscando"
    }
    
    override func viewWillAppear(animated: Bool) {
        if let cityToShow = city {
            title = cityToShow.name
            controller.showWeatherForCity(cityToShow)
        }
    }
    
    func showActivityIndicator() {
        hud!.showInView(self.view)
    }
    
    func hideActivityIndicator() {
        hud!.dismiss()
    }
    
    func showWeatherForCity(weather: CityWeather) {
        self.weather = weather
        updateUI()
    }
    
    func updateUI() {
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let weatherToShow = weather {
            return weatherToShow.weatherDates!.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Weather for Date Cell", forIndexPath: indexPath) as! WeatherForDateTableViewCell
        cell.showWeatherForDate(weather!.weatherDates![indexPath.row])
        return cell
    }
    
}
