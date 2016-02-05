//
//  SearchCityViewControllerDelegate.swift
//  PrevisaoDoTempo
//
//  Created by Ricardo Gehrke Filho on 03/02/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

protocol SearchCityViewControllerDelegate {
    
    func listCitiesWith(cities: [City])
    
    func showProgressIndicator(progress: Float)
    
}