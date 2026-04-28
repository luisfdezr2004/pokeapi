//
//  PokeCell.swift
//  pokeapi
//
//  Created by Luis Fernandez Rodriguez on 22/04/2026.
//

import UIKit

class PokeCell: UITableViewCell {

    @IBOutlet weak var cellView: CellView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(model: PokeCellModel){
        let cellViewModel = CellViewModel(name: model.name,
                                          image: model.image,
                                          id: model.id)
        cellView.configure(model: cellViewModel)
    }
    
}
