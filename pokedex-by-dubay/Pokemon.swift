//
//  Pokemon.swift
//  pokedex-by-dubay
//
//  Created by Joseph DuBay on 7/22/16.
//  Copyright © 2016 DuBay Designs. All rights reserved.
//

import Foundation
import UIKit

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String{
        return _name
    }
    
    var pokedexId: Int{
        return _pokedexId
    }
    
    var image: UIImage{
        return UIImage(named: "\(_pokedexId)")!
    }
    
    init(name: String, pokedexId: Int){
        _pokedexId = pokedexId
        _name = name
    }
    
    
}