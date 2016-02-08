//
//  APIController.swift
//  PrevisaoDoTempo
//
//  Created by Ricardo Gehrke Filho on 03/02/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

import Foundation
import SWXMLHash

//TODO: This part of the code should be moved (Model / Gateway / Usecase / Whatever)

class APIController {
    
    var dateFormater = NSDateFormatter()
    
    var searchCitydelegate: SearchCityDelegate?
    var detailCityWeather: CityWeatherDelegate?
    
    init() {
        dateFormater.dateFormat = "yyy-MM-dd"
    }
    
    func searchForCitiesWith(cityName: String) {
        searchCitydelegate!.showActivityIndicator()
        
        let escapedCityName = cityName.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        
        if let url = NSURL(string: "http://servicos.cptec.inpe.br/XML/listaCidades?city=\(escapedCityName!)") {
            let dataTask = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                
                if let dataRetrieved = data {
                    let xml = SWXMLHash.parse(dataRetrieved)
                    
                    var cityList: [City] = []
                    
                    for cityXML in xml["cidades"]["cidade"] {
                        
                        let id = Int(cityXML["id"].element!.text!)!
                        let name = cityXML["nome"].element!.text!
                        let state = cityXML["uf"].element!.text!
                        
                        cityList.append(City(id: id, name: name, state: state))
                    }
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.searchCitydelegate!.listCitiesWith(cityList)
                        self.searchCitydelegate!.hideActivityIndicator()
                    }
                }
            })
            dataTask.resume()
        }
    }
    
    func showWeatherForCity(city: City) {
        detailCityWeather!.showActivityIndicator()

        if let url = NSURL(string: "http://servicos.cptec.inpe.br/XML/cidade/\(city.id)/previsao.xml") {
            let dataTask = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                
                if let dataRetrieved = data {
                    let xml = SWXMLHash.parse(dataRetrieved)
                    
                    let cityWeather = CityWeather(city: city)
                    
                    let update = self.dateFormater.dateFromString(xml["cidade"]["atualizacao"].element!.text!)
                    
                    cityWeather.update = update
                    
                    for weather in xml["cidade"]["previsao"] {
                        let date = self.dateFormater.dateFromString(weather["dia"].element!.text!)!
                        let status = weather["tempo"].element!.text!
                        let max = Int(weather["maxima"].element!.text!)!
                        let min = Int(weather["minima"].element!.text!)!
                        let uvi = Float(weather["iuv"].element!.text!)!
                        
                        let weatherForDate = WeatherForDate(date: date, statusCode: status, max: max, min: min, uvi: uvi)
                        
                        cityWeather.weatherDates?.append(weatherForDate)
                    }
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.detailCityWeather!.showWeatherForCity(cityWeather)
                        self.detailCityWeather!.hideActivityIndicator()
                    }
                }
            })
            dataTask.resume()
        }
    }
    
}