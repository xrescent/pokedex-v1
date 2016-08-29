//
//  PokemonDetailVC.swift
//  pokedex-v1
//
//  Created by 林柏翰 on 2016/8/26.
//  Copyright © 2016年 林柏翰. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    var pokemon: Pokemon!
    
    
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAtkLbl: UILabel!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    @IBAction func backBtnPressed(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
    }

    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon.name.capitalizedString
        let img = UIImage(named: "\(pokemon.pokedexId)")
            mainImg.image = img
            currentEvoImg.image = img
        pokemon.downloadPokemonDetails { () -> () in
         self.updateUI()
        }
        
        
        }
    
   func updateUI() {
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        baseAtkLbl.text = pokemon.attack
        pokedexLbl.text = "\(pokemon.pokedexId)"
    if pokemon.nextEvoId == "" {
        evoLbl.text = "No Evolutions"
        nextEvoImg.hidden = true
    } else {
        nextEvoImg.hidden = false
        nextEvoImg.image = UIImage(named: pokemon.nextEvoId)
        var str = "Next Evolution: \(pokemon.nextEvoTxt)"
        
        if pokemon.nextEvoLvl != "" {
            str += " Level \(pokemon.nextEvoLvl)"
            evoLbl.text = str
        }
    }
    
    
   }
        
        
        
   override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   }
    

  
    
}