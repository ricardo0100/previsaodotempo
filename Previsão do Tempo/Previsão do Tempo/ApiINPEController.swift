//
//  INPE-API.swift
//  Previsão do Tempo
//
//  Created by Ricardo Gehrke Filho on 02/02/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import SWXMLHash

class ApiINPEController {
    
    var delegate: SearchCityViewControllerDelegate?
    
    func searchForCitiesWith(cityName: String) {
        
        if let url = NSURL(string: "http://servicos.cptec.inpe.br/XML/listaCidades?city=\(cityName)") {

            NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                
                if let dataRetrieved = data {
                
                    let xml = SWXMLHash.parse(dataRetrieved)
                    
                    var cityList: [City] = []
                    
                    for cityXML in xml["cidades"]["cidade"] {
                    
                        let id = Int(cityXML["id"].element!.text!)!
                        let name = cityXML["nome"].element!.text!
                        let state = cityXML["uf"].element!.text!
                        
                        cityList.append(City(id: id, name: name, state: state))
                    }
                    
                    self.delegate!.listCitiesWith(cityList)
                    
                }
                
            }).resume()
            
        }
        
    }
    
}