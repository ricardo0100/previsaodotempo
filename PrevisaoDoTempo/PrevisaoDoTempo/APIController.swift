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

class APIController {
    
    var searchCitydelegate: SearchCityDelegate?
    var detailCityWeather: CityWeatherDelegate?
    
    func searchForCitiesWith(cityName: String) {
        
        searchCitydelegate!.showActivityIndicator()
        let escapedCityName = cityName.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        
        //This part of the code should be moved (Model / Gateway / Usecase / Whatever)
        if let url = NSURL(string: "http://servicos.cptec.inpe.br/XML/listaCidades?city=\(escapedCityName!)") {
            let dataTask = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if let dataRetrieved = data {
                        let xml = SWXMLHash.parse(dataRetrieved)
                    
                        var cityList: [City] = []
                    
                        for cityXML in xml["cidades"]["cidade"] {
                        
                            let id = Int(cityXML["id"].element!.text!)!
                            let name = cityXML["nome"].element!.text!
                            let state = cityXML["uf"].element!.text!
                        
                            cityList.append(City(id: id, name: name, state: state))
                        }
                    
                        self.searchCitydelegate!.listCitiesWith(cityList)
                        self.searchCitydelegate!.hideActivityIndicator()
                    }
                }
            })
            
            dataTask.resume()
        }
        
    }
    
}