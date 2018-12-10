//
//  SignUpViewController.swift
//  WizardSchool
//
//  Copyright © 2018 DevMtnStudent. All rights reserved.
//

import UIKit

protocol EnrollViewControlleDelegate: class  {
    func wizardCreated(wizard: Wizard)
}

class EnrollViewController: UIViewController {
  
    // MARK: - Properties
    
    var selectedTrait: Trait?
    var selectedWand: Wand?
    weak var delegate: EnrollViewControlleDelegate?
    
    @IBOutlet weak var wizardNameTextField: UITextField!
    @IBOutlet weak var almondButton: UIButton!
    @IBOutlet weak var mahoganyButton: UIButton!
    @IBOutlet weak var walnutButton: UIButton!
    @IBOutlet weak var oakButton: UIButton!
    @IBOutlet weak var cunningButton: UIButton!
    @IBOutlet weak var loyalButton: UIButton!
    @IBOutlet weak var braveButton: UIButton!
    @IBOutlet weak var intelligentButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatButtons()
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        // Unwrap the input from the user.
        guard let wizardName = wizardNameTextField.text, !wizardName.isEmpty,
            let trait = selectedTrait,
            let wand = selectedWand
            else { return }
        
        // Initialize a new Wizard
        let wizard = WizardController.enroll(name: wizardName, wand: wand, trait: trait)
        
        // Call our delegate function to inform the parent that a wizard was created
        delegate?.wizardCreated(wizard: wizard)
    }
    
    @IBAction func wandButtonTapped(_ sender: UIButton) {
        var selectedWand: Wand?
        
        switch sender.restorationIdentifier {
        case "almond" :
            selectedWand = .almond
        case "mahogany":
            selectedWand = .mahogany
        case "walnut":
            selectedWand = .walnut
        case "oak":
            selectedWand = .oak
            
        default:
            print("Something went wrong.")
        }
        
        self.selectedWand = selectedWand
    }
    
    @IBAction func traitButtonTapped(_ sender: UIButton) {
        var selectedTrait: Trait?
        
        switch sender.restorationIdentifier {
        case "cunning":
            selectedTrait = .cunning
        case "loyal":
            selectedTrait = .loyal
        case "brave":
            selectedTrait = .brave
        case "intelligent":
            selectedTrait = .intelligent
        default:
            print("Something went wrong.")
        }
        
        self.selectedTrait = selectedTrait
    }
}

extension EnrollViewController {
    
    func formatButtons() {
        almondButton.layer.cornerRadius = 10
        mahoganyButton.layer.cornerRadius = 10
        walnutButton.layer.cornerRadius = 10
        oakButton.layer.cornerRadius = 10
        braveButton.layer.cornerRadius = 10
        cunningButton.layer.cornerRadius = 10
        loyalButton.layer.cornerRadius = 10
        intelligentButton.layer.cornerRadius = 10
    }
}
