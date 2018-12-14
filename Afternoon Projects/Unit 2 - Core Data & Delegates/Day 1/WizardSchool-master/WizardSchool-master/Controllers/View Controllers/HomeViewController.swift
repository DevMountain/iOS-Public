//
//  HomeViewController.swift
//  WizardSchool-master
//
//  Copyright © 2018 DevMountain. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var yourWandLabel: UILabel!
    @IBOutlet weak var yourHouseLabel: UILabel!
    @IBOutlet weak var enrollButton: UIButton!
    @IBOutlet weak var houseImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatButton()
    }
}

extension HomeViewController  {
    
    /**
    Updates the HomeViewController's UI elements after a wizard is created.
     - parameter wizard: A wizard object passed in from the EnrollViewControllerDelegate protocol.
    */
    func updateViews(for wizard: Wizard) {
        welcomeLabel.text = "Welcome \(wizard.name)!"
        yourWandLabel.text = "Your wand is \(wizard.wand.rawValue)."
        houseImageView.image = wizard.houseImage
        yourWandLabel.isHidden = false
        yourHouseLabel.isHidden = false
        houseImageView.isHidden = false
        enrollButton.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEnrollVC" {
            guard let destinationVC = segue.destination as? EnrollViewController else { return }
            // Set self as the delegate of the EnrollViewController
            destinationVC.delegate = self
        }
    }
}

extension HomeViewController {
    
    func formatButton() {
        enrollButton.layer.cornerRadius = 7
    }
}

// Adopt the protocol
extension HomeViewController: EnrollViewControllerDelegate {
    
    // Conform to the protocol
    func wizardCreated(wizard: Wizard) {
        updateViews(for: wizard)
    }
}
