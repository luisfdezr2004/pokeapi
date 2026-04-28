//
//  CellView.swift
//  pokeapi
//
//  Created by Luis Fernandez Rodriguez on 21/04/2026.
//


import Foundation
import UIKit

class CellView: UIView{
    @IBOutlet var view: UIView!
    @IBOutlet weak var labelNombre: UILabel!
    @IBOutlet weak var labelId: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpXIB()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        setUpXIB()
    }
    
    func setUpXIB() {
        let nib = UINib(nibName: "CellView", bundle: Bundle(for: CellView.self))
        self.view = nib.instantiate(withOwner: self).first as? UIView
        self.view.frame = bounds
        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        [view.leadingAnchor.constraint(equalTo: leadingAnchor),
         view.trailingAnchor.constraint(equalTo: trailingAnchor),
         view.topAnchor.constraint(equalTo: topAnchor),
         view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ].forEach { $0.isActive = true }
        
    }
    func configure(model: CellViewModel){
        labelNombre.text = model.name
        labelId.text = String(model.id)
        imageView.image = model.image
        imageView.contentMode = .scaleAspectFit
    }
    
}
