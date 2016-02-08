//
//  CityWeatherViewController.swift
//  PrevisaoDoTempo
//
//  Created by Ricardo Gehrke Filho on 05/02/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import JGProgressHUD
import Slash

class CityWeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CityWeatherDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var hud: JGProgressHUD?
    
    var city: City?
    var weather: CityWeather?
    
    var controller = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller.detailCityWeather = self
        tableView.dataSource = self
        tableView.delegate = self
        
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let weatherToShow = weather {
            return weatherToShow.weatherDates!.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Weather for Date Cell", forIndexPath: indexPath) as! WeatherForDateTableViewCell
        cell.showWeatherForDate(weather!.weatherDates![indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
}

