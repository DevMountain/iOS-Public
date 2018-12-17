//
//  CardViewController.swift
//  DeckOfOneC
//
//  Created by Jayden Garrick on 12/17/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var cardImageView: UIImageView!
    
    // MARK: - ViewLifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func drawButtonTapped(_ sender: Any) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        DVMCardController.drawCard { (card) in
            guard let card = card else { return }
            DVMCardController.fetchCardImage(with: card, completion: { [weak self] (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self?.cardImageView.image = image
                }
            })
        }
    }
    
}
