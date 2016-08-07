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
    private var _discription: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    
    var name: String{
        return _name
    }
    
    var pokedexId: Int{
        return _pokedexId
    }
    
    var image: UIImage{
        return UIImage(named: "\(_pokedexId)")!
    }
    
    var discription: String{
        return _discription
    }
    
    var type: String{
        return _type
    }
    
    var defense: String{
        return _defense
    }
    
    var height: String{
        return _height
    }
    
    var weight: String{
        return _weight
    }
    
    var attack: String{
        return _attack
    }
    
    init(name: String, pokedexId: Int){
        _pokedexId = pokedexId
        _name = name
    }
    
    
}