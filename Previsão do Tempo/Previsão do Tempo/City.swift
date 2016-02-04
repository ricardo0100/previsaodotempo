//
//  City.swift
//  Previsão do Tempo
//
//  Created by Ricardo Gehrke Filho on 02/02/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

class City {

    var id: Int
    var name: String
    var state: String
    
    init(id: Int, name: String, state: String) {
        
        self.id = id
        self.name = name
        self.state = state
        
    }

}