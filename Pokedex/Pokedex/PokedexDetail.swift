//
//  PokedexDetail.swift
//  Pokedex
//
//  Created by mmbs on 05/04/23.
//

import UIKit
import ViewKit
import SDWebImage

class PokedexDetail: UIViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var catchButton: MyButton!
    @IBOutlet weak var areaCollection: UICollectionView!
    @IBOutlet weak var desciption: UILabel!
    @IBOutlet weak var groupsCollection: UICollectionView!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var typeCollection: UICollectionView!
    @IBOutlet weak var backImage: UIButton!
    var pokemonType = [TypeElement]()
    var pokemonSpecies = [DataSpecies]()
    var pokemonAreas = [AreaModelElement]()
    let viewModel = ViewModel()
    var pokemonID: Int?
    var pokemonNameString: String?
    var from = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        typeCollection.dataSource = self
        typeCollection.delegate = self
        groupsCollection.delegate = self
        groupsCollection.dataSource = self
        areaCollection.dataSource = self
        areaCollection.delegate = self
        areaCollection.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let image = UIImage(named: "Back", in: Bundle(identifier: "com.mmbs.Pokemon"), with: nil)
        backImage.setImage(image, for: .normal)
        typeCollection.register(UINib(nibName: "PokemonDetailCell", bundle: Bundle(for: PokemonDetailCell.self)), forCellWithReuseIdentifier: "PokemonDetailCell")
        let urlImage = "https://assets.pokemon.com/assets/cms2/img/pokedex/detail/\(String(format: "%03d", pokemonID!)).png"
        print(urlImage)
        pokemonName.text = pokemonNameString
        pokemonImage.sd_setImage(with: URL(string: urlImage), completed: { image, error, cacheType, imageURL in
            self.loadingIndicator.isHidden = true
            // your rest code
       })
        requestData()
        if (from == "my-list") {
            catchButton.setTitle("Release pokemon", for: .normal)
            catchButton.backgroundColor = UIColor(named: "Red")
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backOnClick(_ sender: Any) {
        back()
    }
    
    @IBAction func cathcOnClick(_ sender: Any) {
        if (from == "my-list") {
            let jsonConfig = JsonConfig()
            jsonConfig.manageJSONFile(value: PokemonData(name: pokemonNameString ?? "", url: ""), isDelete: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
                showToast(message: "Pokemon has been released")
                navigationController?.popViewController(animated: true)
            }
        } else {
            var isSuccess : Bool
            let randomNum = Int.random(in: 1...2)
            print(randomNum)
            if randomNum == 1 {
                isSuccess = true
            } else {
                isSuccess = false
            }
            let vc = CatchView(nibName: "CatchView", bundle: Bundle(for: CatchView.self))
            vc.namePokemon = pokemonNameString
            vc.pokemonID = pokemonID
            vc.success = isSuccess
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    private func requestData() {
        viewModel.getPokemonDetail(pokemonID: pokemonID!)
        viewModel.getPokemonSpecies(pokemonID: pokemonID!)
        viewModel.getPokemonArea(pokemonID: pokemonID!)
        viewModel.pokemonDetail = { [self] detail in
            for data in detail.types {
                pokemonType.append(data)
            }
            typeCollection.reloadData()
        }
        viewModel.species = {[self] species in
            desciption.text = species.flavorTextEntries[0].flavorText
            for data in species.eggGroups {
                pokemonSpecies.append(data)
            }
            groupsCollection.reloadData()
        }
        viewModel.areas = { [self] area in
            for data in area {
                pokemonAreas.append(data)
            }
            areaCollection.reloadData()
        }
    }
}

extension PokedexDetail: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == typeCollection) {
            return pokemonType.count
        } else if (collectionView == groupsCollection){
            return pokemonSpecies.count
        } else if (collectionView == areaCollection) {
            return pokemonAreas.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = typeCollection.dequeueReusableCell(withReuseIdentifier: "PokemonDetailCell", for: indexPath) as! PokemonDetailCell
        if (collectionView == typeCollection) {
            cell.typeName.text = pokemonType[indexPath.row].type.name
        } else if (collectionView == groupsCollection) {
            cell.typeName.text = pokemonSpecies[indexPath.row].name
        } else if (collectionView == areaCollection) {
            cell.typeName.text = pokemonAreas[indexPath.row].locationArea.name.replacingOccurrences(of: "-", with: " ")
        }
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cell = typeCollection.cellForItem(at: indexPath) as? PokemonDetailCell
//        cell?.typeName.sizeToFit()
//        return CGSize(width:(cell?.typeName.frame.width)!, height: 60)
//    }
    
    
}
