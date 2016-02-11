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
                        let statusCode = weather["tempo"].element!.text!
                        let status = self.weatherStatus[statusCode]!
                        let max = Int(weather["maxima"].element!.text!)!
                        let min = Int(weather["minima"].element!.text!)!
                        let uvi = Float(weather["iuv"].element!.text!)!
                        
                        let weatherForDate = WeatherForDate(date: date, status: status, max: max, min: min, uvi: uvi)
                        
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
    
    let weatherStatus: [String: String] = [
        "ec": "Encoberto com Chuvas Isoladas",
        "ci": "Chuvas Isoladas",
        "c": "Chuva",
        "in": "Instável",
        "pp": "Poss. de Pancadas de Chuva",
        "cm": "Chuva pela Manhã",
        "cn": "Chuva a Noite",
        "pt": "Pancadas de Chuva a Tarde",
        "pm": "Pancadas de Chuva pela Manhã",
        "np": "Nublado e Pancadas de Chuva",
        "pc": "Pancadas de Chuva",
        "pn": "Parcialmente Nublado",
        "cv": "Chuvisco",
        "ch": "Chuvoso",
        "t": "Tempestade",
        "ps": "Predomínio de Sol",
        "e": "Encoberto",
        "n": "Nublado",
        "cl": "Céu Claro",
        "nv": "Nevoeiro",
        "g": "Geada",
        "ne": "Neve",
        "nd": "Não Definido",
        "pnt": "Pancadas de Chuva a Noite",
        "psc": "Possibilidade de Chuva",
        "pcm": "Possibilidade de Chuva pela Manhã",
        "pct": "Possibilidade de Chuva a Tarde",
        "pcn": "Possibilidade de Chuva a Noite",
        "npt": "Nublado com Pancadas a Tarde",
        "npn": "Nublado com Pancadas a Noite",
        "ncn": "Nublado com Poss. de Chuva a Noite",
        "nct": "Nublado com Poss. de Chuva a Tarde",
        "ncm": "Nubl. c/ Poss. de Chuva pela Manhã",
        "npm": "Nublado com Pancadas pela Manhã",
        "npp": "Nublado com Possibilidade de Chuva",
        "vn": "Variação de Nebulosidade",
        "ct": "Chuva a Tarde",
        "ppn": "Poss. de Panc. de Chuva a Noite",
        "ppt": "Poss. de Panc. de Chuva a Tarde",
        "ppm": "Poss. de Panc. de Chuva pela Manhã"
    ]
}