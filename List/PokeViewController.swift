//
//  ViewController.swift
//  pokeapi
//
//  Created by Luis Fernandez Rodriguez on 21/04/2026.
//

import UIKit
import SwiftUI

class PokeViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var botonAtras: UIButton!
    @IBOutlet weak var botonDelante: UIButton!
    var cellModels: [PokeCellModel] = []
    var isFetching: Bool = false
    var offset: Int = 0
    let limit: Int = 14

    @IBAction func tocarAtras(_ sender: Any) {
        if(offset >= limit){
            offset -=  limit
            loadMoreData()
        }
    }
    @IBAction func tocarDelante(_ sender: Any) {
        if(offset < 1025-limit){
            offset += limit
            loadMoreData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        loadMoreData()
        // Do any additional setup after loading the view.
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "PokeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PokeCell")
    }
    
    func loadMoreData() {
        isFetching = true
        Task{
            do{
                cellModels.removeAll()
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
                let wrapper = try await ApiNetwork().getPokemons(limit: limit, offset: offset)
                for pokemon in wrapper.results{
                    let id = URL(string: pokemon.url)!.lastPathComponent
                    let image = try loadImages(id: id)
                    let model = PokeCellModel(name: pokemon.name, image: image, id: Int(id)!)
                    cellModels.append(model)

                }
                activityIndicator.isHidden = true
            } catch let error{
                
                DispatchQueue.main.async{
                    print(error)
                    let modalView = ModalView()
                    modalView.onReintentar = {[weak self] in
                        self?.loadMoreData()
                    }
                    self.present(modalView, animated: true)
                }}
            tableView.reloadData()
        }
        isFetching = false
        
    }
    
    func loadImages(id: String) throws -> UIImage?{
        let imageURLString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
        let imageURL = URL(string: imageURLString)!
        let data = try Data(contentsOf: imageURL)
        let image = UIImage(data: data)
        return image
    }
    
    func gotoDetail(detail: DetailPokemonModel) {
        let viewController = DetailPokemonViewController(nibName: "DetailPokemonViewController", bundle: nil)
        viewController.pokemon = detail
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }

}



extension PokeViewController: UITableViewDelegate, UITableViewDataSource {
    //Numero de celdas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count //cellModels.count
    }
    
    //Celdas
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell") as? PokeCell
        let model = cellModels[indexPath.row]
        cell?.configure(model: model)
        return cell!
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath.row == cellModels.count - 1 && !isFetching){
            //loadMoreData()
        }
    }

    func detalle(didSelectRowAt indexPath: IndexPath){
        Task{
            do{
                let pokemon = try await ApiNetwork().getPokemonById(id: indexPath.row+offset + 1)
                let tipos: [ApiNetwork.types] = pokemon.types
                let detail = DetailPokemonModel(id: offset + indexPath.row + 1, name: pokemon.name, height: pokemon.height, weight: pokemon.weight, types: tipos, image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(offset + indexPath.row + 1).png")
//                let id: Int
//                let name: String
//                let height: Int
//                let weight: Int
//                let types: [type]
//                let image: String
                gotoDetail(detail: detail)
            } catch{
                DispatchQueue.main.async{
                    print("El error es el siguiente \(error)")
                    let modalView = ModalView()
                    modalView.onReintentar = {[weak self] in
                        self?.detalle(didSelectRowAt: indexPath)
                    }
                    self.present(modalView, animated: true)
                }}
            }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
            detalle(didSelectRowAt: indexPath)
        }
    }
