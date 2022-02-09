//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // ––––– TODO: Add storyboard Items (i.e. tableView + Cell + configurations for Cell + cell outlets)
    // ––––– TODO: Next, place TableView outlet here
    
    @IBOutlet weak var tableView: UITableView!
    
    // –––––– TODO: Initialize restaurantsArray
    var restaurantsArray: [[String:Any?]] = []
    
    
    
    // ––––– TODO: Add tableView datasource + delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAPIData()
        tableView.rowHeight = 150
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    
    // ––––– TODO: Get data from API helper and retrieve restaurants
    func getAPIData(){
        API.getRestaurants() { (restaurants) in
            guard let restaurants = restaurants else{
                return
            }
            print(restaurants)
            self.restaurantsArray = restaurants
            self.tableView.reloadData() // reload data!
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create Restaurant Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        let restaurant = restaurantsArray[indexPath.row]
        
        // Set label to restaurant name for each cell
        cell.label.text = restaurant["name"] as? String ?? ""
        
        cell.categoryLabel.text = restaurant["categories[].title"] as? String
        
        /*
        // Rating
        // get the rating value
         let ratingValue = restaurant["rating"] as! Decimal
        
        //cell.rating.image = UIImage(named: "regular_0")
        
        
        // calculate which image it would be
        if(ratingValue == 0){
            cell.rating.image = UIImage(named: "regular_0")
        } else if(ratingValue == 1){
            cell.rating.image = UIImage(named: "regular_1")
        } else if(ratingValue == 1.5){
            cell.rating.image = UIImage(named: "regular_1_half")
        } else if(ratingValue == 2){
            cell.rating.image = UIImage(named: "regular_2")
        } else if(ratingValue == 2.5){
            cell.rating.image = UIImage(named: "regular_2_half")
        } else if(ratingValue == 3){
            cell.rating.image = UIImage(named: "regular_3")
        } else if(ratingValue == 3.5){
            cell.rating.image = UIImage(named: "regular_3_half")
        } else if(ratingValue == 4){
            cell.rating.image = UIImage(named: "regular_4")
        } else if(ratingValue == 4.5){
            cell.rating.image = UIImage(named: "regular_4_half")
        } else if(ratingValue == 5){
            cell.rating.image = UIImage(named: "regular_5")
        } else{
            cell.rating.image = UIImage(named: "regular_0")
        }
         */
        
        // set image
        
        // Set Image of restaurant
        if let imageUrlString = restaurant["image_url"] as? String {
            let imageUrl = URL(string: imageUrlString)
            cell.restaurantImage.af.setImage(withURL: imageUrl!)
        }
        
        return cell
    }

}

// ––––– TODO: Create tableView Extension and TableView Functionality


