//
//  PokemonCell.swift
//  Pokedex
//
//  Created by mmbs on 05/04/23.
//

import UIKit

class PokemonCell: UITableViewCell {

    @IBOutlet weak var imgPokemon: UIImageView!
    @IBOutlet weak var namePokemon: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
