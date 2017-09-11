//
//  TableViewCell.swift
//  HACodingChallenge
//
//  Created by Chris Conner on 9/6/17.
//  Copyright © 2017 Chris Conner. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var heartBadge: UIImageView!
    
    var imageLocationString:String!
    var eventIDString:Int!
    let defaults = UserDefaults.standard
    
    //This started out as a method to set the labels but I've overloaded it to load the image and to set the corner radius
    func setEvent(event: Event) {
        
        titleLabel.text = event.title
        locationLabel.text = event.location
        imageLocationString = event.locationImage
        eventIDString = event.id
        
        if imageLocationString != nil {
            if let url = URL.init(string: imageLocationString) {
                imgView.downloadedFrom(url: url)
            } else {
                imgView.image = UIImage(imageLiteralResourceName: "defaultPlaceholder.png")
            }
        }
        
        imgView.layer.cornerRadius = 12
        imgView.clipsToBounds = true
    }
    
    //This is to convert our date string to conform with the requirement (This probably belongs in an extension so I don't call it in two places)
    func convertDateFormatter(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        
        guard let date = dateFormatter.date(from: date) else {
            assert(false, "no date from string")
            return ""
        }
        
        dateFormatter.dateFormat = "EEE, dd MMM hh:mm a"
        dateFormatter.timeZone = TimeZone.current
        dateTimeLabel.text = dateFormatter.string(from: date)
        return dateTimeLabel.text!
    }
    
    //Check to see if this property is favorited, and if so show the badge
    func heartCheck() {
        let eventID = "\(eventIDString)"
        let isHearted = defaults.bool(forKey: eventID)
        if isHearted == true {
            heartBadge.image = #imageLiteral(resourceName: "heartIsSelected.png")
        } else {
            heartBadge.image = nil
        }
    }
    
}
