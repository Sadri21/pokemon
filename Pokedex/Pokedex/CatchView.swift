//
//  CatchView.swift
//  Pokedex
//
//  Created by mmbs on 05/04/23.
//

import UIKit
import ConfigKit
import SDWebImage
import ViewKit

class CatchView: UIViewController {
    
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: MyButton!
    @IBOutlet weak var labelname: UILabel!
    @IBOutlet weak var titleSuccess: UILabel!
    @IBOutlet weak var messageSuccess: UILabel!
    @IBOutlet weak var pokemonRealName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UITextField!
    var pokemonURL: String?
    var pokemonID: Int?
    var namePokemon: String?
    var pokemnArray = [PokemonData]()
    var success: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonURL = "\(BASE_URL)pokemon/\(pokemonID ?? 0)/"
        pokemonRealName.text = namePokemon
        let imageURL = "https://assets.pokemon.com/assets/cms2/img/pokedex/full/\(String(format: "%03d", pokemonID!)).png"
        print(imageURL)
        pokemonImage.sd_setImage(with: URL(string: imageURL), completed: { image, error, cacheType, imageURL in
            // your rest code
            self.loadingIndicator.isHidden = true
       })
        if (success) {
            messageSuccess.text = "congratulation you are success catching"
            titleSuccess.text = "Yeey! You're sucess"
        } else {
            messageSuccess.text = "You failed catching, "
            titleSuccess.text = "Oh no! This is not your day"
            labelname.text = "He/She fled into the forest"
            pokemonName.isHidden = true
            saveButton.setTitle("Try Again!", for: .normal)
            saveButton.backgroundColor = UIColor(named: "Red")
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func saveOnClick(_ sender: Any) {
        if (success) {
            if (pokemonName.text != "") {
                let pokemon = PokemonData(name: pokemonName.text!, url: pokemonURL ?? "")
                let jsonConfig = JsonConfig()
                jsonConfig.manageJSONFile(value: pokemon, isDelete: false)
                showToast(message: "Pokemon has been captured")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    // Code to be executed after a 5 second delay
                    if let navigationController = self.navigationController {
                        navigationController.popToRootViewController(animated: true)
                    }
                }
                
            } else {
                showToast(message: "Please give monster new name")
            }
        } else {
            navigationController!.popViewController(animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
