//
//  CharacterTableViewCell.swift
//  RickAndMortyApp
//
//  Created by João Paulo on 18/10/18.
//  Copyright © 2018 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var charImageView: UIImageView!
    @IBOutlet weak var roundedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundedView.layer.cornerRadius = 5
        roundedView.clipsToBounds = true
//        shadowView.layer.masksToBounds = false
//        shadowView.layer.shadowOpacity = 0.7
//        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
//        shadowView.layer.shadowColor = #colorLiteral(red: 0.2626901792, green: 0.2652910721, blue: 0.2652910721, alpha: 1)
//        shadowView.layer.shadowRadius = 6
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
