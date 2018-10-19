//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by João Paulo de Oliveira Sabino on 18/10/18.
//  Copyright © 2018 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var characters = [Character]()
    var locations = [Location]()
    var episodes = [Episode]()
    var actualPage = 1
    var apiManager = APIManager.manager
    
    var searchController = UISearchController()
    var scopeButtonTitles = ["Characters","Locations", "Episodes"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "characterCell")
        
        syncRequest(byPage: actualPage)
        
        setSearchController()
        
    }
    
    
    func syncRequest(byPage : Int){
        apiManager.fetchBy(typeSearch: .character,query: "page=\(byPage)") { (request: RootRequest<Character>) in
            guard let char = request.characters else {return}
            self.characters.append(contentsOf: char)
            self.tableView.reloadData()
            
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            
        // UITableView only moves in one direction, y axis
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        // Change (height of view*1.5) to adjust the distance from bottom
        if maximumOffset - currentOffset <= self.view.frame.height*1.5 {
            print("load more...")
            actualPage += 1
            syncRequest(byPage: actualPage)
            
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterTableViewCell
        
        cell.nameLabel?.text = characters[indexPath.row].name
        cell.typeLabel.text = characters[indexPath.row].type
        cell.charImageView.image = UIImage(named: "placeholderImage")
        
        DispatchQueue.main.async {
            if let image = self.characters[indexPath.row].image, let imageURL = URL(string: image) {
                cell.charImageView.downloaded(from: imageURL)

            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    
}

extension ViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating{
    
    func setSearchController() {
        
        let sc = UISearchController(searchResultsController: nil)
        sc.delegate = self
        sc.searchResultsUpdater = self
        sc.dimsBackgroundDuringPresentation = false
        let scb = sc.searchBar
        scb.delegate = self
        scb.tintColor = UIColor(named: "black")
        scb.barTintColor = UIColor.white
        scb.scopeButtonTitles = scopeButtonTitles

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

        if let navigationbar = self.navigationController?.navigationBar {
            navigationbar.barTintColor = UIColor(named: "green")
        }
        navigationItem.searchController = sc
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }
    
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
}



