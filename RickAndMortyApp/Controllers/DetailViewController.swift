//
//  DetailViewController.swift
//  RickAndMortyApp
//
//  Created by João Paulo de Oliveira Sabino on 22/10/18.
//  Copyright © 2018 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


    var character: Character?
    
    var delegate : SendInstanceDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var specieLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var originNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var episodesNamesLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let char = delegate?.sendCharacter() else {return}
        
        imageView.image = char.uiImage
        nameLabel.text = char.name
        statusLabel.text = char.status
        specieLabel.text = char.species
        genderLabel.text = char.gender
        typeLabel.text = char.type
        
        if char.type == "" {
            typeLabel.text = "N/A"
        }
        
        originNameLabel.text = char.origin?.name
        locationLabel.text = char.location?.name
        
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        
        navigationItem.title = char.name
    }


}
