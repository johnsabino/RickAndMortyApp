//
//  LocationTableViewCell.swift
//  RickAndMortyApp
//
//  Created by João Paulo de Oliveira Sabino on 23/10/18.
//  Copyright © 2018 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var titleLabel_2: UILabel!
    @IBOutlet weak var label_2: UILabel!
    
    @IBOutlet weak var titleLabel_3: UILabel!
    @IBOutlet weak var label_3: UILabel!
    
    @IBOutlet weak var titleLabel_4: UILabel!
    @IBOutlet weak var label_4: UILabel!
    
    @IBOutlet weak var roundedView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        roundedView.layer.cornerRadius = 5
        roundedView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
