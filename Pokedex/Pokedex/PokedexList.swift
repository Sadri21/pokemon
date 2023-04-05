//
//  PokedexList.swift
//  Pokedex
//
//  Created by mmbs on 05/04/23.
//

import UIKit
import ViewKit
import SDWebImage
import ConfigKit


public class PokedexList: UIViewController {

    @IBOutlet weak var imageBack: UIButton!
    @IBOutlet weak var pokemonTableView: UITableView!
    var offset = 0
    var limit = 20
    var listData = [PokemonData]()
    @IBOutlet weak var menuTitle: UILabel!
    let viewModel = ViewModel()
    var isLoading = false
    public var from: String?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        let image = UIImage(named: "Back", in: Bundle(identifier: "com.mmbs.Pokemon"), with: nil)
        imageBack.setImage(image, for: .normal)
      
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        pokemonTableView.register(UINib(nibName: "PokemonCell", bundle: Bundle(for: PokemonCell.self)), forCellReuseIdentifier: "PokemonCell")
        if (from == "my-list") {
            menuTitle.text = "My Pokemon"
        } else {
            menuTitle.text = "Pokemon List"
        }
        
        // Do any additional setup after loading the view.
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        if (from == "my-list") {
            let jsonConfig = JsonConfig()
            listData = jsonConfig.getJsonData()
            pokemonTableView.reloadData()
        } else {
            requestData()
        }
    }

    @IBAction func backOnClick(_ sender: Any) {
        back()
    }
    
    private func requestData() {
        viewModel.getPokemon(offset: offset, limit: limit)
        viewModel.isLoading = { [self] loading in
            isLoading = loading
        }
        viewModel.pokemon = { [self] pokemon in
            for data in pokemon.results {
                listData.append(data)
            }
            pokemonTableView.reloadData()
        }
    }

}

extension PokedexList: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pokemonTableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonCell
        cell.namePokemon.text = listData[indexPath.row].name
        let urlPokemon = listData[indexPath.row].url.components(separatedBy: "/")
        let idPokemon = urlPokemon[urlPokemon.count - 2]
        let urlString = "\(IMAGE_URL)/\(idPokemon).png"
        cell.imgPokemon.sd_setImage(with: URL(string: urlString), completed: nil)
        return cell
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == pokemonTableView {
            let isAtBottom = isTableViewScrolledToBottom(tableView: pokemonTableView)
            if isAtBottom {
                print("scroll")
                if (!isLoading) {
                    offset += limit
                    requestData()
                }
            } else {
        
            }
        }
    }
    
    func isTableViewScrolledToBottom(tableView: UITableView) -> Bool {
        let contentHeight = tableView.contentSize.height
        let tableViewHeight = tableView.frame.size.height
        let contentYOffset = tableView.contentOffset.y
        let distanceFromBottom = contentHeight - contentYOffset - tableViewHeight
        return distanceFromBottom < 0
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PokedexDetail(nibName: "PokedexDetail", bundle: Bundle(for: PokedexDetail.self))
        vc.pokemonNameString = listData[indexPath.row].name
        let urlPokemon = listData[indexPath.row].url.components(separatedBy: "/")
        let idPokemon = urlPokemon[urlPokemon.count - 2]
        vc.pokemonID = Int(idPokemon)
        vc.from = from ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
