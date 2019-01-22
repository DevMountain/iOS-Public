//
//  FlashlightViewController.swift
//  Flashlight-Master-BlackDiamond
//
//  Created by Karl Pfister on 1/18/19.
//  Copyright © 2019 Karl Pfister. All rights reserved.
//

import UIKit
// Need to import AVFoundation to gain access to the flashlight
import AVFoundation

class FlashlightViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var FlashlightToggleButton: UIButton!
    
    //MARK: Properties
    var isOn: Bool = false // Creates a boolean for us to track the flashlights state. default value is false - or "Off"
    var gestureRecognizer: UISwipeGestureRecognizer?
    var statusBarStyle: UIStatusBarStyle = .lightContent // With the backgound starting black I want the intial status bar to be white
    
    //MARK: ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        swipe(direction: isOn ? .right : .left)
    }
    
    // MARK: Methods
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    // Flashlight Toggle Logic
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        if device.hasTorch && device.isTorchAvailable {
            do {
                try device.lockForConfiguration()
                device.torchMode = on ? .on : .off
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used \(device.systemPressureState)")
            }
        } else {
            print("Torch is not available)")
        }
    }
    // Swipe Gesture Logic
    func swipe(direction: UISwipeGestureRecognizer.Direction) {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(FlashlightToggleButtonTapped(_:)))
        swipeGestureRecognizer.direction = direction
        view.addGestureRecognizer(swipeGestureRecognizer)
        gestureRecognizer = swipeGestureRecognizer
    }
    
    // MARK: Actions
    @IBAction func FlashlightToggleButtonTapped(_ sender: Any) {
        isOn = !isOn
        // Ternary operators
        view.backgroundColor = isOn ? .white : .black
        FlashlightToggleButton.setTitle(isOn ? "Turn Off" : "Turn On", for: .normal)
        FlashlightToggleButton.setTitleColor(isOn ? .black : .white, for: .normal)
        statusBarStyle = isOn ? .default : .lightContent
        // Update the statusbar color
        setNeedsStatusBarAppearanceUpdate()
        // Turn on the flash
        toggleTorch(on: isOn)
        // Handle the gesture
        guard let gesture = gestureRecognizer else {return}
        view.removeGestureRecognizer(gesture)
        swipe(direction: isOn ? .right : .left)
    }
}
