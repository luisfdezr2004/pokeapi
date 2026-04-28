//
//  ModalView.swift
//  pokeapi
//
//  Created by Luis Fernandez Rodriguez on 24/04/2026.
//

import Foundation
import UIKit

let label = UILabel()

class ModalView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
        setupButton()
    }
    
    var onReintentar: (() -> Void)?
    
    func setupLabel() {
        label.text = "Error de conexión, intentelo de nuevo"
        label.textAlignment = .center
        label.textColor = .red
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupButton(){
        let button = UIButton()
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Reintentar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(botonPulsado), for: .touchUpInside)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
    ])
    }
    
    @objc func botonPulsado(){
        self.dismiss(animated: true){
            self.onReintentar?()
        }
    }
}
