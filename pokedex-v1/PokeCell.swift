//
//  PokeCell.swift
//  pokedex-v1
//
//  Created by 林柏翰 on 2016/8/26.
//  Copyright © 2016年 林柏翰. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
        
    }
    
    func configureCell(pokemon: Pokemon){
        self.pokemon = pokemon
        nameLbl.text = self.pokemon.name.capitalizedString
        thumbImg.image = UIImage(named:"\(self.pokemon.pokedexId)")
    }
    
}
