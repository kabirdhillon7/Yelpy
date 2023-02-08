//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import AlamofireImage
import Lottie
import SkeletonView

class RestaurantsViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    // Initiliazers
    var restaurantsArray: [Restaurant] = []
    var filteredRestaurants: [Restaurant] = []
    
    let yelpyRefresh = UIRefreshControl()
    
    var animationView: AnimationView?
    
    var refresh = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimations()
        
        // Table View
        tableView.delegate = self
        tableView.dataSource = self
        
        // Search Bar delegate
        searchBar.delegate = self
        
        // Get Data from API
        getAPIData()
        
        // Refresh Controll
        yelpyRefresh.addTarget(self, action: #selector(getAPIData), for: .valueChanged)
        tableView.refreshControl = yelpyRefresh
        
        
        // Animations
        animationView = .init(name: "animationName")
        animationView?.frame = view.bounds
        animationView?.play()
        
        
        stopAnimations()
    }
    
    @objc func getAPIData() {
        API.getRestaurants() { (restaurants) in
            guard let restaurants = restaurants else {
                return
            }
            self.restaurantsArray = restaurants
            self.filteredRestaurants = restaurants
            self.tableView.reloadData()
            
            self.yelpyRefresh.endRefreshing()
        }
    }
    
    
}

// ––––– TableView Functionality –––––
extension RestaurantsViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "RestaurantCell"
    }
    
    func startAnimations() {
        animationView = .init (name: "4762-food-carousel")
        // - 1. Set the size to the frame
        animationView!.frame = view.bounds
        animationView!.frame = CGRect(x: view.frame.width / 3 , y: 0, width: 100, height: 100)
        // fit the animation
        animationView!.contentMode = .scaleAspectFit
        view.addSubview (animationView!)
        //- 2. Set animation loop mode
        animationView!.loopMode = .loop
        // 3. Animation speed - Larger number = faste
        animationView!.animationSpeed = 5
        // 4. Play animation
        animationView!.play()
    }
    
    @objc func stopAnimations() {
        // 1. Stop Animation
        animationView?.stop()
        //2. Change the subview to last and remove the current subview
        view.subviews.last?.removeFromSuperview()
        refresh = false
    }
}

extension RestaurantsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRestaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create Restaurant Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        // Set cell's restaurant
        cell.r = filteredRestaurants[indexPath.row]
        
        if self.refresh {
            cell.showAnimatedSkeleton()
        } else {
            cell.hideSkeleton()
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let r = filteredRestaurants[indexPath.row]
            let detailViewController = segue.destination as! RestaurantDetailViewController
            detailViewController.r = r
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath:IndexPath) {
        if indexPath.row + 1 == self.restaurantsArray.count {
            getAPIData()
        }
    }
}

extension RestaurantsViewController: UISearchBarDelegate {
    
    // Search bar functionality
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            filteredRestaurants = restaurantsArray.filter { (r: Restaurant) -> Bool in
                return r.name.lowercased().contains(searchText.lowercased())
            }
        }
        else {
            filteredRestaurants = restaurantsArray
        }
        tableView.reloadData()
    }
    
    
    // Show Cancel button when typing
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    // Logic for searchBar cancel button
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false // remove cancel button
        searchBar.text = "" // reset search text
        searchBar.resignFirstResponder() // remove keyboard
        filteredRestaurants = restaurantsArray // reset results to display
        tableView.reloadData()
    }
}





