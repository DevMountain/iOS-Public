//
//  FlashlightViewController.swift
//  Flashlight-Master-BlackDiamond
//
//  Created by Karl Pfister on 1/18/19.
//  Copyright © 2019 Karl Pfister. All rights reserved.
//

import UIKit

class FlashlightViewController: UIViewController {

    
    //MARK: Outlets
    @IBOutlet weak var FlashlightToggleButton: UIButton!
    
    //MARK: Properties
    var isOn: Bool = false // Creates a boolean for us to track the flashlights state. default value is false - or "Off"
    
    //MARK: ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Actions
    @IBAction func FlashlightToggleButtonTapped(_ sender: Any) {
        if isOn == true {
            // When the button is tapped, and the "light" is on, let's turn it off.
            self.view.backgroundColor = .black
            // We want the text to change with the flashlights state.
            FlashlightToggleButton.setTitle("Turn On", for: .normal)
            FlashlightToggleButton.setTitleColor(.white, for: .normal)
            
            isOn = false // Set the boolean to the desired State.
        } else {
            // When the button is tapped and the "light" is off, let's turn it on.
            self.view.backgroundColor = .white
            // We want the text to change with the flashlights state.
            FlashlightToggleButton.setTitle("Turn Off", for: .normal)
            FlashlightToggleButton.setTitleColor(.black, for: .normal)
            
            isOn = true // Set the boolean to the desired State.
        }
    }
    
}
