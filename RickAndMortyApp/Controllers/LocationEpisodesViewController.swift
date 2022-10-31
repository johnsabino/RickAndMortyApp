//
//  LocationEpisodesViewController.swift
//  RickAndMortyApp
//
//  Created by João Paulo de Oliveira Sabino on 24/10/18.
//  Copyright © 2018 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

class LocationEpisodesViewController: UIViewController {

    var delegate : SendInstanceDelegate?
    var characters = [Character]()
    
    var apiManager = APIManager.manager
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var label_2: UILabel!
    @IBOutlet weak var label_3: UILabel!
    @IBOutlet weak var label_4: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var specieLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "characterCollectionCell")
        collectionView.isPagingEnabled = true
        
        
        if let _ = delegate?.sendLocation().id {
            guard let location = delegate?.sendLocation() else {return}
            nameLabel.text = location.name
            label_2.text = "TYPE"
            statusLabel.text = location.type
            label_3.text = "DIMENSION"
            label_4.text = "RESIDENTS"
            specieLabel.text = location.dimension
            navigationItem.title = location.name
            
            location.residents?.forEach({ (url) in
                fetchChar(charURL: url)
            })
            
        }else if let _ = delegate?.sendEpisode().id {
            guard let episode = delegate?.sendEpisode() else {return}
            nameLabel.text = episode.name
            label_2.text = "EPISODE"
            statusLabel.text = episode.episode
            label_3.text = "AIR DATE"
            label_4.text = "CHARACTERS"
            specieLabel.text = episode.airDate
            navigationItem.title = episode.episode
            
            episode.characters?.forEach({ (url) in
                fetchChar(charURL: url)
            })
        }
        
        apiManager.syncImages(chars: self.characters) {
            self.collectionView.reloadData()
        }
        
    }

    func fetchChar(charURL : String) {
        apiManager.fetchChar(charURL: charURL) { (char) in
            self.characters.append(char)
            self.collectionView.reloadData()
        }
    }
}

extension LocationEpisodesViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(characters.count)
        return characters.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 200.0, height: 240.0)
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCollectionCell", for: indexPath) as! CharacterCollectionViewCell
        
        let char = characters[indexPath.item]
        cell.name.text = char.name
        
        cell.image?.image = UIImage(named: "placeholderImage")
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            //pega a url da imagem que está na pasta Fotos e a retorna
            let charId = String(char.id!)
            let fileURL = URL(fileURLWithPath: dir.absoluteString).appendingPathComponent("\(charId).jpeg").path
            
            
            if let img = UIImage(contentsOfFile:fileURL){
                cell.image?.image = img
                char.uiImage = img
            }else{
                DispatchQueue.main.async {
                    if let image = char.image, let imageURL = URL(string: image) {
                        UIImageView.downloaded(from: imageURL, completion: { (img) in
                            cell.image?.image = img
                            char.uiImage = img
                        })
                        
                    }
                }
            }
        }
        return cell
        
    }
    
    
}
