//
//  APIManager.swift
//  RickAndMortyApp
//
//  Created by João Paulo de Oliveira Sabino on 18/10/18.
//  Copyright © 2018 João Paulo de Oliveira Sabino. All rights reserved.
//

import Foundation

class APIManager {
    
    public static var manager = APIManager()
    
    private init(){}
    
    func fetch(completion: @escaping (CharRequest) -> Void){
        
        let baseURL = Config.baseURL
        let queryStr = "/"
        guard let getURL = baseURL?.appendingPathComponent(queryStr)
            else {
                print("error url not found")
                return
        }
        var getRequest = URLRequest(url: getURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
    
        getRequest.httpMethod = "GET"
        let getTask = URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let charachersData = try decoder.decode(CharRequest.self, from: data)
                DispatchQueue.main.async {
                    completion(charachersData)
                }
            } catch let err {
                print("Error", err)
            }
        }
        DispatchQueue.global(qos: .userInteractive).async {getTask.resume()}
    }
    
    func downloadImage(from url: URL, completion: @escaping (Data) -> Void) {
        let getRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        let getTask = URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            
            guard let data = data else {return}
            DispatchQueue.main.async {
                completion(data)
            }
            
        }
        DispatchQueue.global(qos: .userInteractive).async {getTask.resume()}
    }
}
