//
//  DetailViewController.swift
//  HACodingChallenge
//
//  Created by Chris Conner on 9/6/17.
//  Copyright © 2017 Chris Conner. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //image and labels
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var titleString:String!
    var dateAndTimeString:String!
    var cityString:String!
    var imageLocationString:String!
    var eventIDString:Int!
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        convertDateFormatter(date: dateAndTimeString)
        heartCheck()
        title = titleString
        
        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "BackButton.png"), for: .normal)
        backbutton.setTitle("Back", for: .normal)
        backbutton.setTitleColor(backbutton.tintColor, for: .normal)
        backbutton.addTarget(self, action: Selector(("backAction")), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        print("Image location = \(imageLocationString)")
        
        if imageLocationString != nil {
            if let url = URL.init(string: imageLocationString) {
                imgView.downloadedFrom(url: url)
            } else {
                if imageLocationString == nil {
                    imgView.image = #imageLiteral(resourceName: "defaultPlaceholder.png")
                }
            }
            imgView.layer.cornerRadius = 10
            imgView.clipsToBounds = true
            
        }
    }
    
    //This is to create our fake back button
    @IBAction func backAction(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //This is for the heart toggle button
    var buttonIsSelected = false
    @IBOutlet weak var onOffButton: UIButton!
    
    
    @IBAction func onOffButtonTapped(_ sender: Any) {
        buttonIsSelected = !buttonIsSelected
        updateOnOffButton()
    }
    
    func heartCheck() {
        let eventID = "\(eventIDString)"
        let isHearted = defaults.bool(forKey: eventID)
        if isHearted == true {
            onOffButton.setBackgroundImage(#imageLiteral(resourceName: "heartIsSelected.png"), for: .normal)
        } else {
            onOffButton.setBackgroundImage(#imageLiteral(resourceName: "heartUnselected.png"), for: .normal)
        }
    }
    
    func updateOnOffButton() {
        let eventID = "\(eventIDString)"
        let isHearted = defaults.bool(forKey: eventID)
        if buttonIsSelected && isHearted != true {
            onOffButton.setBackgroundImage(#imageLiteral(resourceName: "heartIsSelected.png"), for: .normal)
            defaults.set(true, forKey: eventID)
            print("Set Favorite")
        }
        else {
            onOffButton.setBackgroundImage(#imageLiteral(resourceName: "heartUnselected.png"), for: .normal)
            defaults.set(false, forKey: eventID)
            print("Removed Favorite")
        }
    }
    
    //This is to convert the date and time string to conform with the requirement
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
    
    //This is to fill in the text labels
    func updateUI() {
        dateTimeLabel.text = dateAndTimeString
        locationLabel.text = cityString
        titleLabel.text = titleString
    }
    
}
