//
//  Pokemon.swift
//  pokedex-by-dubay
//
//  Created by Joseph DuBay on 7/22/16.
//  Copyright © 2016 DuBay Designs. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _discription: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLvl: String!
    private var _pokemonUrl: String!
    
    
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
        
        if _discription == nil{
            _discription = ""
        }
        return _discription
    }
    
    var type: String{
        
        if _type == nil{
            _type = ""
        }
        return _type
    }
    
    var defense: String{
        
        if _defense == nil{
            _defense = ""
        }
        return _defense
    }
    
    var height: String{
        
        if _height == nil{
            _height = ""
        }
        return _height
    }
    
    var weight: String{
        
        if _weight == nil{
            _weight = ""
        }
        return _weight
    }
    
    var attack: String{
        
        if _attack == nil{
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionTxt: String{
        
        if _nextEvolutionTxt == nil{
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var nextEvolutionId: String{
        
        if _nextEvolutionId == nil{
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLvl: String{
        
        if _nextEvolutionLvl == nil{
            _nextEvolutionLvl = ""
        }
        return _nextEvolutionLvl
    }
    
    
    init(name: String, pokedexId: Int){
        _pokedexId = pokedexId
        _name = name
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(_pokedexId)"
    }
    
    func downloadPokemonDetails(compleated: DownloadComplete){
        
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            //print(result.debugDescription)
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String{
                    self._height = height
                }
                
                if let attack = dict ["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int{
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0{
                    self._type = types[0]["name"]?.capitalizedString
                    
                    if types.count > 1 {
                        
                        for x in 1 ..< types.count {
                            self._type = "\(self._type)/\(types[x]["name"]!.capitalizedString)"
                            //self.type += types[x]["name"]
                        }
                        
                    }
                    print("Types are: \(self._type)")
                } else{
                    self._type = ""
                }
             
                if let descArray = dict["descriptions"] as? [Dictionary<String, String>] where descArray.count > 0 {
                    if let urlString = descArray[0]["resource_uri"]{
                        let discUrl = NSURL(string: "\(URL_BASE)\(urlString)")!
                        Alamofire.request(.GET, discUrl).responseJSON { response in
                            let discResult = response.result
                            if let discDict = discResult.value as? Dictionary<String, AnyObject>{
                                
                                if let discription = discDict["description"] as? String{
                                    self._discription = discription
                                    print ("discription is :\(discription)")
                                    
                                }
                            }
                            
                          
                            compleated()
                        }
                    }
                }
                
                if let evolutions =  dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0{
                    
                    if let to = evolutions [0]["to"] as? String{
                        
                        if to.rangeOfString("mega") == nil {
                            if let uri = evolutions[0]["resource_uri"] as? String{
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                
                                self._nextEvolutionId = num
                                self._nextEvolutionTxt = to
                                
                                if let level = evolutions[0]["level"] as? Int{
                                    self._nextEvolutionLvl = "\(level)"
                                }
                                
                                
                            }
                        }
                    }
                    
                } else{
                
                }
            }
            
            
        }
        
        
        
    }
    
}