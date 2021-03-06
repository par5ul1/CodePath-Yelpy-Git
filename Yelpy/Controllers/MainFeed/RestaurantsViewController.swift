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
    
    // –––––  Lab 4: create an animation view
    
    
    var animationView: AnimationView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ––––– Lab 4 TODO: Start animations
        self.startAnimations()

        
        // Table View
        tableView.delegate = self
        tableView.dataSource = self
        
        // Search Bar delegate
        searchBar.delegate = self
        
        // Get Data from API
        getAPIData()
        
        // –––––  Lab 4: stop animations, you can add a timer to stop the animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0 )
            {
            self.stopAnimations()
        }
        
        self.stopAnimations()
        
    }
    
    
    @objc func getAPIData() {
        API.getRestaurants() { (restaurants) in
            guard let restaurants = restaurants else {
                return
            }
            self.restaurantsArray = restaurants
            self.filteredRestaurants = restaurants
            self.tableView.reloadData()
            
        }
    }
    

    // ––––– Lab 4 TODO: Call animation functions to start
    func startAnimations() {

        animationView = .init(name: "4762-food-carousel")
        // Set the size to the frame
        //animationView!.frame = view.bounds
        animationView!.frame = CGRect(x: view.frame.width / 3 , y: 156, width: 100, height: 100)

        // fit the
        animationView!.contentMode = .scaleAspectFit
        view.addSubview(animationView!)
        
        // 4. Set animation loop mode
        animationView!.loopMode = .loop

        // Animation speed - Larger number = faste
        animationView!.animationSpeed = 5

        //  Play animation
        animationView!.play()
        
    }
   
    
    // ––––– Lab 4 TODO: Call animation functions to stop
    
    @objc func stopAnimations() {
        // ----- Stop Animation
        animationView?.stop()
        // ------ Change the subview to last and remove the current subview
        view.subviews.last?.removeFromSuperview()

        
    }
    
    
}

// ––––– TableView Functionality –––––
extension RestaurantsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRestaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create Restaurant Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        // Set cell's restaurant
        cell.r = filteredRestaurants[indexPath.row]
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
