//
//  WeatherForDateTableViewCell.swift
//  PrevisaoDoTempo
//
//  Created by Ricardo Gehrke Filho on 08/02/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class WeatherForDateTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var UVILabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!

    var weather: WeatherForDate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func showWeatherForDate(weather: WeatherForDate) {
        self.weather = weather
        updateUI()
    }
    
    func updateUI() {
        updateDateLabel()
        updateStatusLabel()
        updateUVILavel()
        updateMaxLabel()
        updateMinLabel()
    }
    
    func updateDateLabel() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateLabel.text = dateFormatter.stringFromDate(weather!.date)
    }
    
    func updateStatusLabel() {
        statusLabel.text = weather!.status
    }
    
    func updateUVILavel() {
        UVILabel.text = String(weather!.uvi)
    }
    
    func updateMaxLabel() {
        maxLabel.text = "\(weather!.max) ºC"
    }
    
    func updateMinLabel() {
        minLabel.text = "\(weather!.min) ºC"
    }
}
