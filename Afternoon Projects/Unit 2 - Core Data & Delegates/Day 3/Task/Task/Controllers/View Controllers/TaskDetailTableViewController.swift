//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Frank Martin Jr on 1/22/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet var datePicker: UIDatePicker!
    
    // MARK: - Constants & Variables

    var task: Task? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dueTextField.inputView = datePicker
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {

        // Unwrap the name text field and ensure that the string is not empty
        guard let name = nameTextField.text,
            !name.isEmpty
            else { return }
        
        // If we are in the detail view for an existing task, unwrap it
        if let task = task {
            
            // Update the task
            TaskController.shared.update(task, name: name, notes: notesTextView.text, due: datePicker.date)
        } else {
            
            // Create a new task
            TaskController.shared.createTaskWith(name, notesTextView.text, datePicker.date)
        }
        
        // Pop the detail vc off the navigation stack
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerChaged(_ sender: UIDatePicker) {
        dueTextField.text = "\(sender.date)"
    }
    
    func updateViews() {
        guard let task = task else { return }
        nameTextField.text = task.name
        dueTextField.text = task.due != nil ? String(describing: task.due!) : ""
        
    }
}
