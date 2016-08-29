//
//  Pokemon.swift
//  pokedex-v1
//
//  Created by 林柏翰 on 2016/8/26.
//  Copyright © 2016年 林柏翰. All rights reserved.
//

import Foundation
import Alamofire
class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvoTxt: String!
    private var _nextEvoId: String!
    private var _nextEvoLvl: String!
    private var _pokemonUrl: String!
    
    var name: String {
        return _name
    }
    var pokedexId: Int {
        return _pokedexId
    }
    var description: String {
        get {
            if _description == nil {
                _description = ""
            }
            return _description
        }
    }

    var type: String {
        get {
            if _type == nil {
                _type = ""
            }
            return _type
        }
    }
    var defense: String{
        get {
            if _defense == nil {
                _defense = ""
            }
            return _defense
        }
    }
    var height: String{
        get {
            if _height == nil {
                _height = ""
            }
            return _height
        }
    }
    var weight: String{
        get {
            if _weight == nil {
                _weight = ""
            }
            return _weight
        }
    }
    var attack: String{
        get {
            if _attack == nil {
                _attack = ""
            }
            return _attack
        }
    }
    var nextEvoTxt: String{
        get {
            if _nextEvoTxt == nil {
                _nextEvoTxt = ""
            }
            return _nextEvoTxt
        }
    }
    var nextEvoId: String{
        get {
            if _nextEvoId == nil {
                _nextEvoId = ""
            }
            return _nextEvoId
        }
    }

    var nextEvoLvl: String{
        get {
            if _nextEvoLvl == nil {
                _nextEvoLvl = ""
            }
            return _nextEvoLvl
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    init(name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId

        
     _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
   func downloadPokemonDetails(completed: DownloadComplete) {
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let _result = response.result
            if let dict = _result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    if let name = types[0]["name"]{
                        self._type = name.capitalizedString
                    }
                    if types.count > 1 {
                        if let name = types[1]["name"]{
                            self._type! += "/\(name.capitalizedString)"
                        }
//                        for x in 0...types.count-1{
//                            if let name = types[x]["name"]{
//                                self._type! += "/\(name.capitalizedString)"
//                            }
//                        }
                    }
                } else {
                    self._type = ""
                    }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0 {
                 if let url = descArr[0]["resource_uri"] {
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                    Alamofire.request(.GET, nsurl).responseJSON{ response in
                        let descResult = response.result
                        if let descDist = descResult.value as? Dictionary<String, AnyObject>{
                            if let description = descDist["description"] as? String {
                                self._description = description.stringByReplacingOccurrencesOfString("POKMON", withString: "pokemon")
                                print(self._description)
                            }
                        }
                    completed()
                    }
                    
                    
                } else {
                    self._description = ""
                }
                
                    if let evolutionsArr = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutionsArr.count > 0 {
                        
                        if let to = evolutionsArr[0]["to"] as? String {
                            if to.rangeOfString("mega") == nil {
                                if let uri = evolutionsArr[0]["resource_uri"] as? String {
                                    let tempNum = uri.stringByReplacingOccurrencesOfString("api/v1/pokemon/", withString:"")
                                    let num = tempNum.stringByReplacingOccurrencesOfString("/", withString: "")
                                    self._nextEvoId = num
                                    self._nextEvoTxt = to
                                    
                                    if let lvl = evolutionsArr[0]["level"] as? Int {
                                        self._nextEvoLvl = "\(lvl)"
                                     print(self._nextEvoTxt)
                                     print(self._nextEvoLvl)
                                    }
                                    
                                    
                                    
                                    
                                    
                                }
                            }
                        }
                        
                        
                    }
                    
                    
                    
                    
                
                
            }
        }
    }
    
}
}
