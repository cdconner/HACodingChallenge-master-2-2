//
//  ViewController.swift
//  HACodingChallenge
//
//  Created by Chris Conner on 9/6/17.
//  Copyright © 2017 Chris Conner. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    let baseURL = "https://api.seatgeek.com/2/"
    var newSearchText = "nothing"
    var myEvents: [Event] = []
    let searchController = UISearchController(searchResultsController: nil)
    let defaults = UserDefaults.standard
    var imageUrl = URL.self
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //This is for our UISearchController
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for an event"
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor.white
        UISearchBar.appearance().barTintColor = UIColor(colorLiteralRed: 34/255, green: 60/255, blue: 98/255, alpha: 1)
        //UINavigationBar.appearance().barTintColor = UIColor(colorLiteralRed: 34/255, green: 60/255, blue: 98/255, alpha: 1)
        tableView.tableHeaderView = searchController.searchBar
//        navigationItem.titleView = searchController.searchBar
        DispatchQueue.main.async(execute: {() -> Void in
            self.tableView.delegate = self
            self.tableView.dataSource = self
        })
    }
    
    //Any time a user types a character into the search field we will call the JSON handler and pass the new value
    func updateSearchResults(for searchController: UISearchController) {
        myEvents.removeAll()
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            let newSearchText = searchText.replacingOccurrences(of: " ", with: "+") as String
            print(newSearchText)
            downloadJsonWithURL(searchText: newSearchText)
        } else {
            print("No updates yet")
        }
    }
    
    //This is where we call to get and then parse the JSON
    func downloadJsonWithURL(searchText: String) {
        
        // Building the URL
        let seatGeekClientID = "ODgwMzA0OHwxNTA0NzM4MTE2LjI1"
        let searchQuery = searchText
        let eventURL = baseURL + "events?client_id=\(seatGeekClientID)&q=\(searchQuery)"
        let url = URL(string: eventURL)
        
        var request = URLRequest(url: url as! URL)
        
        URLSession.shared.dataTask(with: (url!), completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                //                print(jsonObj!.value(forKey: "events"))
                
                // Pull out items we need
                // Create temp dictionary
                // Input into dictionary
                // Create event with dictionary
                
                if let eventsArray = jsonObj!.value(forKey: "events") as? [[String:Any]] {
                    for event in eventsArray {
                        
                        // Grabbing all the information I need. Digging through JSON
                        
                        //Top Level
                        let title    = event["title"] as! String
                        let dateTime = event["datetime_utc"] as! String
                        let id       = event["id"] as! Int
                        
                        
                        // Had to dig to some sub-nodes
                        let venueDict = event["venue"] as! [String:Any]
                        let location = venueDict["display_location"] as! String
                        let performersArray = event["performers"] as! [[String:Any]]
                        let searchedItemDict = performersArray.first!
                        let locationImage = searchedItemDict["image"] as? String
                        
                        
                        // Throw these items into my dictionary
                        let tempDict: [String:Any?] = [
                            "id": id,
                            "title": title,
                            "datetime_utc": dateTime,
                            "display_location": location,
                            "image": locationImage
                        ]
                        
                        let newEvent = Event(data: tempDict as Any as! [String : Any])
                        self.myEvents.append(newEvent)
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }).resume()
    }
    
    func updateTheTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    //Setting the number of rows that will appear in our tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myEvents.count
    }
    
    //Sending the data for the specific cells to render with the necessary info
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        let event = myEvents[indexPath.row]
        cell.imageLocationString = event.locationImage
        cell.setEvent(event: event)
        cell.convertDateFormatter(date: event.dateTime!)
        cell.heartCheck()
        return cell
    }
    
    //To send users from the TableView to the Detail View with the necessary info
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let event = myEvents[indexPath.row]
        vc.titleString = event.title
        vc.dateAndTimeString = event.dateTime
        vc.cityString = event.location
        vc.imageLocationString = event.locationImage
        vc.eventIDString = event.id
        navigationController?.pushViewController(vc, animated: true)
        searchController.dismiss(animated: false, completion: nil)
    }
}










