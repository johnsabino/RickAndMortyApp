//
//  APIManager.swift
//  RickAndMortyApp
//
//  Created by João Paulo de Oliveira Sabino on 18/10/18.
//  Copyright © 2018 João Paulo de Oliveira Sabino. All rights reserved.
//

import Foundation
import UIKit

class APIManager {
    
    public static var manager = APIManager()
    
    private init(){}
    
    func fetch(type: TypeSearch, query : String, completion: @escaping (Data) -> Void){
        let baseURL = Config.baseURL
        guard let getURL = baseURL?.appendingPathComponent(type.rawValue) else {
                print("error url not found")
                return
        }

        guard let urlComponents = NSURLComponents(url: getURL, resolvingAgainstBaseURL: false) else {return}
        urlComponents.query = query
        guard let endPoint = urlComponents.url else {return}
        print("URL:\(endPoint)")
        var getRequest = URLRequest(url: getURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        getRequest.httpMethod = "GET"
       
        let getTask = URLSession.shared.dataTask(with: endPoint) { (data, response, error) in
            guard let data = data else {return}
            
            completion(data)
        }
        
        DispatchQueue.global(qos: .userInteractive).async {getTask.resume()}
    }
    
    func fetchBy<T: Codable>(typeSearch: TypeSearch, query: String ,completion: @escaping (RootRequest<T>) -> Void){
        self.fetch(type: typeSearch, query: query) { (data) in
            do {
                let decoder = JSONDecoder()
                let charachersData = try decoder.decode(RootRequest<T>.self, from: data)
        
                DispatchQueue.main.async {
                    completion(charachersData)
                }
                
            } catch let err {
                print("Error", err)
            }
        }
    }
    
    func syncImages(chars: [Character], completion: @escaping () -> Void){
        DispatchQueue.main.async {
            for character in chars {
                if let image = character.image, let imageURL = URL(string: image) {
                    
                    UIImageView.downloaded(from: imageURL, completion: { (img) in
                        let fileManager = FileManager.default
                        
                        if let data = img.jpegData(compressionQuality: 1) ?? img.pngData(),
                            //diretorio da pasta documents
                            let diretorio = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as URL{
                            
                            let pathComponent = diretorio.appendingPathComponent("\(character.id ?? 000).jpeg")
                            //print(pathComponent)
                            let filePath = pathComponent.path
                            //print(filePath)
                            
                            if !fileManager.fileExists(atPath: filePath) {
                                do {
                                    try data.write(to: diretorio.appendingPathComponent("/\(character.id ?? 000).jpeg"))
                                    print("Foto Salva!")
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }else{
                                print("FOTO JÁ EXISTE")
                            }
                        }
                        
                    })
                }
            }
            completion()
        }
        
    }
    
}
