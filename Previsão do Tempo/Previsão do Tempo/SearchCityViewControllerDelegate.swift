//
//  BuscarCidadesViewControllerDelegate.swift
//  Previsão do Tempo
//
//  Created by Ricardo Gehrke Filho on 02/02/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

protocol SearchCityViewControllerDelegate {
    
    func listCitiesWith(cities: [City])
    
}