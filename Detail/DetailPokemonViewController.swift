//
//  ViewController.swift
//  pokeapi
//
//  Created by Luis Fernandez Rodriguez on 22/04/2026.
//

import UIKit

class DetailPokemonViewController: UIViewController {

    var pokemon: DetailPokemonModel?
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var weight: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = pokemon?.name
        height.text = String(Float(pokemon!.height)/10)
        weight.text = String(Double(pokemon!.weight)/10)
        stackView.backgroundColor = .black
        Task{
            do{
                let image = try loadImages(url: pokemon!.image)
                imageView.image = image
                imageView.contentMode = .scaleAspectFit
            }
        }
        
        for tipo in pokemon!.types{
            let id = URL(string: tipo.type.url)!.lastPathComponent
            Task{
                do{
                    let typeDetail = try await ApiNetwork().getTypeSprite(id: Int(id)!)
                    let ImageUI = try loadImages(url: typeDetail.sprites.generationViii.swordShield.name_icon)
                    let imageView = UIImageView(image: ImageUI)
                    imageView.contentMode = .scaleAspectFit
                    stackView.addArrangedSubview(imageView)
                }
            }
        }
    }

    func loadImages(url: String) throws -> UIImage?{
        let imageURL = URL(string: url)!
        let data = try Data(contentsOf: imageURL)
            let image = UIImage(data: data)
            return image
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
