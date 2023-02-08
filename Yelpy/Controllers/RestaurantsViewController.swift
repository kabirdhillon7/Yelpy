//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    var restaurantsArray: [Restaurant] = []
    var filteredRestaurants: [Restaurant]!
    
    var searchActive : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        filteredRestaurants = restaurantsArray
        
        getAPIData()
    }
    
    func getAPIData() {
        API.getRestaurants() { (restaurants) in
            guard let restaurants = restaurants else {
                return
            }
            self.restaurantsArray = restaurants
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        
        if let indexPath = tableView.indexPath(for: cell) {
            let r = restaurantsArray[indexPath.row]
            let detailViewController = segue.destination as! RestaurantDetailViewController
            detailViewController.r = r
        }
    }
    
}
extension RestaurantsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchActive) {
            return filteredRestaurants.count
        }
        return restaurantsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create Restaurant Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        let restaurant: Restaurant
        if (searchActive){
            restaurant = filteredRestaurants[indexPath.row]
        } else {
            restaurant = restaurantsArray[indexPath.row]
        }
        
        cell.r = restaurant
        
        return cell
    }
}

extension RestaurantsViewController: UISearchBarDelegate {
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredRestaurants = searchText.isEmpty ? restaurantsArray : restaurantsArray.filter { (item: Restaurant) -> Bool in
            return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchActive = false;
        self.filteredRestaurants = restaurantsArray
        self.tableView.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        searchBar.resignFirstResponder()
    }
}
