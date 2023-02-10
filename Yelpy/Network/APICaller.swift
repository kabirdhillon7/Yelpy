//
//  File.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import Foundation

enum API: String {
    case key = "gjSp5LrrEi9tJFLQALnw-RdZSRy-TLiJsfPM09LzFMNpMnmSHQZ2n2R_f3ptONYEalxMIudE9avxn_bQvvDZJc1zpPdfPDOvdh08RlT8vZGbqFx3dbtkuliMwATHXnYx"
}

struct APICaller {
    
    static func getRestaurants(completion: @escaping ([Restaurant]?) -> Void) {
        
        let apikey = API.key.rawValue
        
        // Coordinates for San Francisco
        let lat = 37.773972
        let long = -122.431297
        
        guard let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)") else {
            print("Unable to get url with latitude: \(lat) and longitude: \(long)")
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let restDictionaries = dataDictionary["businesses"] as! [[String: Any]]
                
                let restaurants = restDictionaries.map({ Restaurant.init(dict: $0) })
                
                return completion(restaurants)
            }
        }
        
        task.resume()
    }
}


