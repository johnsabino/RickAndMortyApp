//
//  FavoriteViewController.swift
//  RickAndMortyApp
//
//  Created by João Paulo de Oliveira Sabino on 27/10/18.
//  Copyright © 2018 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var fetchedResultsController : NSFetchedResultsController<FavoriteChar>!
    var context = CoreDataManager.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "characterCell")
        
        loadSavedData()
    }


}

extension FavoriteViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.layer.bounds.height / 4.2
        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterTableViewCell
        let favoriteChar = fetchedResultsController.object(at: indexPath)
        
        cell.selectionStyle = .none
        cell.nameLabel.text = favoriteChar.name
        cell.titleLabel_2.text = "STATUS"
        cell.label_2.text = favoriteChar.status
        cell.titleLabel_3.text = "SPECIES"
        cell.label_3.text = favoriteChar.specie
        cell.titleLabel_4.text = "GENDER"
        cell.label_4.text = favoriteChar.gender
        
        //cell.contentView.accessibilityIdentifier = "\(indexPath.row)"
        //registerForPreviewing(with: self, sourceView: cell.contentView)
        
        cell.charImageView.image = UIImage(named: "placeholderImage")
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            //pega a url da imagem que está na pasta Fotos e a retorna
            let charId = favoriteChar.id
            let fileURL = URL(fileURLWithPath: dir.absoluteString).appendingPathComponent("\(charId ?? "000").jpeg").path
            
            
            if let img = UIImage(contentsOfFile:fileURL){
                cell.charImageView?.image = img
                //favoriteChar.uiImage = img
            }
        }
        
        return cell
    }
    
    
}

extension FavoriteViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    func loadSavedData() {
        if fetchedResultsController == nil {
            
            let request : NSFetchRequest<FavoriteChar> = FavoriteChar.fetchRequest()
            let sort = NSSortDescriptor(key: "id", ascending: true)
            request.sortDescriptors = [sort]
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = self
        }
        
        //fetchedResultsController.fetchRequest.predicate = NSPredicate(format: "name == %@", "INFRAERO")
        
        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch {
            print("Fetch failed")
        }
    }
}
