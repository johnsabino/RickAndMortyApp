//
//  DetailViewController.swift
//  RickAndMortyApp
//
//  Created by João Paulo de Oliveira Sabino on 22/10/18.
//  Copyright © 2018 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var uiImage : UIImage?
    var nameStr: String?
    var originNameStr: String?
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originNameLabel: UILabel!
    @IBOutlet weak var episodesNamesLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = uiImage
        nameLabel.text = nameStr
        originNameLabel.text = originNameStr
        
    }


}
