//
//  ViewController.swift
//  Previsão do Tempo
//
//  Created by Ricardo Gehrke Filho on 02/02/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import SWXMLHash

class ViewController: UIViewController, SearchCityViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //Test on the API of INPE (Instituto Nacional de Pesquisas Espaciais - Brazil) http://servicos.cptec.inpe.br/XML/
        
        let city = "J"
        
        let controller = ApiINPEController()
        controller.delegate = self
        
        controller.searchForCitiesWith(city)
        
    }
    
    func listCitiesWith(cities: [City]) {
        
        for city in cities {
            print(city.name)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

