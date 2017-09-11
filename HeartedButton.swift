//
//  HeartedButton.swift
//  HACodingChallenge
//
//  Created by Chris Conner on 9/9/17.
//  Copyright © 2017 Chris Conner. All rights reserved.
//

import UIKit

class HeartedButton: UIViewController {

    
    var buttonIsSelected = false
    @IBOutlet weak var onOffButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateOnOffButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onOffButtonTapped(_ sender: Any) {
        buttonIsSelected = !buttonIsSelected
        updateOnOffButton()
    }
    
    func updateOnOffButton() {
        if buttonIsSelected {
            onOffButton.backgroundColor = UIColor.blue
        }
        else {
            onOffButton.backgroundColor = UIColor.white
        }
    }
    
}

