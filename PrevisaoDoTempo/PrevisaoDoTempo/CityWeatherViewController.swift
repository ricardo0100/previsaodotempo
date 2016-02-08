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

class CityWeatherViewController: UIViewController, CityWeatherDelegate {

    @IBOutlet weak var updateLabel: UILabel!
    
    
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
        updateUpdateLabel()
    }
    
    func updateUpdateLabel() {
        let str = "Última atualização: <strong>\(weather!.updateString())</strong>"
        var attrStr: NSAttributedString?
        do {
            try attrStr = SLSMarkupParser.attributedStringWithMarkup(str)
        } catch {
            attrStr = nil
        }
        updateLabel.attributedText = attrStr
    }
    
}
