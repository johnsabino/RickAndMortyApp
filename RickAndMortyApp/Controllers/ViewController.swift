//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by João Paulo de Oliveira Sabino on 18/10/18.
//  Copyright © 2018 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var characters = [Character]()
    var locations = [Location]()
    var episodes = [Episode]()
   
    var selectedType : TypeSearch = .character
    var actualPage = 1
    var apiManager = APIManager.manager
    
    var selectedChar : Character?
    var writing = false
    var searchController = UISearchController()
    var scopeButtonTitles = ["Characters","Locations", "Episodes"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "characterCell")
        tableView.register(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "locationCell")
        

        syncRequest(typeSearch: .character, query: "page=\(actualPage)")
        
      
        setSearchController()
        
    }
    
    func syncRequest(typeSearch: TypeSearch, query : String){
        
        switch typeSearch {
        case .character:
        
            apiManager.fetchBy(typeSearch: typeSearch, query: query) { (request: RootRequest<Character>) in
                guard let result = request.characters else {return}
                self.apiManager.syncImages(chars: result, completion: {
                    print("synccccccccc")
                    self.characters.append(contentsOf: result)
                    self.tableView.reloadData()
                })
            }
            
        case .location:
            apiManager.fetchBy(typeSearch: typeSearch,query: query) { (request: RootRequest<Location>) in
                guard let result = request.characters else {return}
                self.locations.append(contentsOf: result)
                self.tableView.reloadData()
            }
        case .episode:
            
            apiManager.fetchBy(typeSearch: typeSearch,query: query) { (request: RootRequest<Episode>) in
                guard let result = request.characters else {return}
                self.episodes.append(contentsOf: result)
                self.tableView.reloadData()
                
            }
        default:
            print("ERROR")
        }
        
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberRows = 0
        
        switch selectedType {
        case .character:
            numberRows = characters.count
        case .location:
            numberRows = locations.count
        case .episode:
            numberRows = episodes.count
        default:
            numberRows = 0
        }

        return numberRows
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.layer.bounds.height / 3.5
        return height
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            
        // UITableView only moves in one direction, y axis
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        // Change (height of view*1.5) to adjust the distance from bottom
        print(maximumOffset - currentOffset)
        if maximumOffset - currentOffset <= -100 {
            print("load more...")
            actualPage += 1
            if !writing {
                syncRequest(typeSearch: selectedType, query: "page=\(actualPage)")
            }
            
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        switch selectedType {
        case .character:
            let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterTableViewCell
            let char = characters[indexPath.row]
            
            cell.selectionStyle = .none
            cell.nameLabel?.text = char.name
            cell.titleLabel_2.text = "STATUS"
            cell.label_2.text = char.status
            cell.titleLabel_3.text = "SPECIES"
            cell.label_3.text = char.species
            cell.titleLabel_4.text = "GENDER"
            cell.label_4.text = char.gender
            
            cell.contentView.accessibilityIdentifier = "\(indexPath.row)"
            registerForPreviewing(with: self, sourceView: cell.contentView)
            
            //print(characters[indexPath.row].imageFilePath)
            
            cell.charImageView.image = UIImage(named: "placeholderImage")
            if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
                //pega a url da imagem que está na pasta Fotos e a retorna
                let charId = String(char.id!)
                let fileURL = URL(fileURLWithPath: dir.absoluteString).appendingPathComponent("\(charId).jpeg").path
                
                
                if let img = UIImage(contentsOfFile:fileURL){
                    cell.charImageView?.image = img
                    char.uiImage = img
                }else{
                    DispatchQueue.main.async {
                        if let image = char.image, let imageURL = URL(string: image) {
                            UIImageView.downloaded(from: imageURL, completion: { (img) in
                                cell.charImageView.image = img
                                char.uiImage = img
                            })

                        }
                    }
                }
            }
     
            return cell
            
        case .location:
            let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationTableViewCell
            
            let location = locations[indexPath.row]
            
            cell.selectionStyle = .none
            cell.nameLabel?.text = location.name
            cell.titleLabel_2.text = "TYPE"
            cell.label_2.text = location.type
            cell.titleLabel_3.text = "DIMENSION"
            cell.label_3.text = location.dimension
            
            cell.contentView.accessibilityIdentifier = "\(indexPath.row)"
            registerForPreviewing(with: self, sourceView: cell.contentView)
            
            return cell
        case .episode:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationTableViewCell
            
            let episode = episodes[indexPath.row]
            
            cell.selectionStyle = .none
            cell.nameLabel?.text = episode.name
            cell.titleLabel_2.text = "EPISODE"
            cell.label_2.text = episode.episode
            cell.titleLabel_3.text = "AIR DATE"
            cell.label_3.text = episode.airDate
            
            cell.contentView.accessibilityIdentifier = "\(indexPath.row)"
            registerForPreviewing(with: self, sourceView: cell.contentView)
            
            return cell
        default:
            print("ERRO")
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchController.isActive = false
        selectedChar = characters[indexPath.row]
        performSegue(withIdentifier: "segueDetail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let favoriteAction = UITableViewRowAction(style: .normal, title: "Favorite") { (favoriteAction, indexPath) in
            
            var isFavorite = false
            let char = self.characters[indexPath.row]
            let fetch : NSFetchRequest<FavoriteChar> = FavoriteChar.fetchRequest()
            let favoriteChars = CoreDataManager.fetch(fetch)
            
            for favChar in favoriteChars {
                if favChar.id == String(char.id!) {
                    isFavorite = true
                }
            }
            if !isFavorite {
                _ = FavoriteChar(char: char)
            }
        }
        return [favoriteAction]
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueDetail" {
            let vc = segue.destination as! DetailViewController
 
                vc.character = selectedChar
    
            
        }
    }
}

extension ViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating{
    
    func setSearchController() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        let scb = searchController.searchBar
        scb.delegate = self
        scb.tintColor = UIColor(named: "black")
        scb.barTintColor = UIColor.white
        scb.scopeButtonTitles = scopeButtonTitles
        scb.setImage(UIImage(named: "placeholderImage"), for: UISearchBar.Icon.bookmark, state: .normal)
        
        if let textfield = scb.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.blue
            if let backgroundview = textfield.subviews.first {
                // Background color
                backgroundview.backgroundColor = UIColor.white
                
                // Rounded corner
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }

        if let navigationBar = self.navigationController?.navigationBar {
            //navigationBar.setBackgroundImage(UIImage(), for: .default)
            //navigationBar.shadowImage = UIImage()
            navigationBar.barTintColor = UIColor(named: "green")
            navigationBar.tintColor = UIColor(named: "black") ?? UIColor.black
        }
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchhhhh")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            writing = false
        }else{
            writing = true
        }
        print(writing)
        self.characters = []
        syncRequest(typeSearch: .character, query: "name=\(searchText)")
    }
    
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        actualPage = 1
        
        switch selectedScope {
        case 0:
            selectedType = .character
            syncRequest(typeSearch: .character, query: "page=\(actualPage)")
        case 1:
            selectedType = .location
            syncRequest(typeSearch: .location, query: "page=\(actualPage)")
        case 2:
            selectedType = .episode
            syncRequest(typeSearch: .episode, query: "page=\(actualPage)")
        default:
            print("erro")

        }
    }
}

extension ViewController : UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        let content = previewingContext.sourceView
        
        guard let indexPath = Int(content.accessibilityIdentifier!) else {return nil}
        
    
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as? DetailViewController else { return nil }
    
        detailVC.preferredContentSize = CGSize(width: 0.0, height: 300)
        detailVC.character = characters[indexPath]
        
        return detailVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        show(viewControllerToCommit, sender: self)
        
    }
}


