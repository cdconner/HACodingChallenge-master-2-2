//
//  JSON Handler.swift
//  HACodingChallenge
//
//  Created by Chris Conner on 9/10/17.
//  Copyright © 2017 Chris Conner. All rights reserved.
//

//import Foundation
//import UIKit
//
//
//let baseURL = "https://api.seatgeek.com/2/"
//var myEvents: [Event] = []
//let searchController = UISearchController(searchResultsController: nil)
//
////Any time a user types a character into the search field we will call the JSON handler and pass the new value
//func updateSearchResults(for searchController: UISearchController) {
//    myEvents.removeAll()
//    if let searchText = searchController.searchBar.text, !searchText.isEmpty {
//        let newSearchText = searchText.replacingOccurrences(of: " ", with: "+") as String
//        print(newSearchText)
//        downloadJsonWithURL(searchText: newSearchText)
//    } else {
//        print("No updates yet")
//    }
//    //self.tableView.reloadData()
//}
//
////This is where we call to get and then parse the JSON
//func downloadJsonWithURL(searchText: String) {
//    
//    // Building the URL
//    let seatGeekClientID = "ODgwMzA0OHwxNTA0NzM4MTE2LjI1"
//    let searchQuery = searchText
//    let eventURL = baseURL + "events?client_id=\(seatGeekClientID)&q=\(searchQuery)"
//    
//    
//    let url = URL(string: eventURL)
//    
//    var request = URLRequest(url: url as! URL)
//    
//    URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
//        
//        if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
//            print(jsonObj!.value(forKey: "events"))
//            
//            // Pull out items we need
//            // Create temp dictionary
//            // Input into dictionary
//            // Create event with dictionary
//            
//            if let eventsArray = jsonObj!.value(forKey: "events") as? [[String:Any]] {
//                
//                for event in eventsArray {
//                    
//                    // Grabbing all the information I need. Digging through JSON
//                    
//                    //Top Level
//                    let title    = event["title"] as! String
//                    let dateTime = event["datetime_utc"] as! String
//                    let id       = event["id"] as! Int
//                    
//                    
//                    // Had to dig to some sub-nodes
//                    let venueDict = event["venue"] as! [String:Any]
//                    let location = venueDict["display_location"] as! String
//                    
//                    let performersArray = event["performers"] as! [[String:Any]]
//                    let searchedItemDict = performersArray.first as! [String:Any]
//                    
//                    let locationImage = searchedItemDict["image"] as? String
//                    
//                    
//                    // Throw these items into my dictionary
//                    let tempDict: [String:Any?] = [
//                        "id": id,
//                        "title": title,
//                        "datetime_utc": dateTime,
//                        "display_location": location,
//                        "image": locationImage
//                    ]
//                    
//                    let newEvent = Event(data: tempDict)
//                    
//                    myEvents.append(newEvent)
//                }
//            }
//            
//            DispatchQueue.main.async {
//                tableView.reloadData()
//            }
//        }
//        
//    }).resume()
//}

