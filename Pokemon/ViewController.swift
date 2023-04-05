//
//  ViewController.swift
//  Pokemon
//
//  Created by mmbs on 04/04/23.
//

import UIKit
import Pokedex
import ViewKit

class ViewController: UIViewController {
    
    @IBOutlet weak var buttonPokeball: MyButton!
    @IBOutlet weak var buttonPokedex: MyButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        print("test")
        buttonPokedex.imageView?.contentMode = .scaleAspectFit
        buttonPokedex.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        buttonPokeball.imageView?.contentMode = .scaleAspectFit
        buttonPokeball.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    @IBAction func myListPokedex(_ sender: Any) {
        let vc = PokedexList(nibName: "PokedexList", bundle: Bundle(for: PokedexList.self))
        vc.from = "my-list"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func toPokedexOnClick(_ sender: Any) {
        let vc = PokedexList(nibName: "PokedexList", bundle: Bundle(for: PokedexList.self))
        vc.from = "dashboard"
        self.navigationController?.pushViewController(vc, animated: true)
       
        
    }
}

