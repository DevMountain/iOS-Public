//
//  SwitchTableViewCell.swift
//  Task
//
//  Created by Frank Martin on 2/21/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func isCompleteToggled(on cell: SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dueLabel: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!
    
    // MARK: - Constants & Variables
    
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: SwitchTableViewCellDelegate?
    
    // MARK: - Actions
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        delegate?.isCompleteToggled(on: self)
    }
}

extension SwitchTableViewCell {
    
    func updateViews() {
        
        guard let task = task else { return }
        nameLabel.text = task.name
        task.due != nil ? (dueLabel.text = String(describing: task.due!)) : (dueLabel.isHidden = true)
        
        let image: UIImage? = task.isComplete ? UIImage(named: "complete") : UIImage(named: "incomplete")
        isCompleteButton.setBackgroundImage(image, for: .normal)
    }
}
