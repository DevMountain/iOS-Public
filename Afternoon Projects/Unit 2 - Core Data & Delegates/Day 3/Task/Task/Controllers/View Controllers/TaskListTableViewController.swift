//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Frank Martin Jr on 1/22/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? SwitchTableViewCell  else { return UITableViewCell() }

        let task = TaskController.shared.tasks[indexPath.row]
        cell.task = task
        cell.delegate = self
        
        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let task = TaskController.shared.tasks[indexPath.row]
            
            // Delete the row from the data source
            TaskController.shared.delete(task)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Check that we are firing the code for the correct segue
        if segue.identifier == "toTaskDetail" {
            // Cast the destination view controller as our custom detail vc
            guard let destinationVC = segue.destination as? TaskDetailTableViewController,
                // Grab the indexPath of the row that was selected
                let indexPath = tableView.indexPathForSelectedRow
                else { return }
            
            // Index the source of truth
            let task = TaskController.shared.tasks[indexPath.row]
            // Pass the task to the detail vc
            destinationVC.task = task
        }
    }
}

extension TaskListTableViewController: SwitchTableViewCellDelegate {
    
    func isCompleteToggled(on cell: SwitchTableViewCell) {
        guard let task = cell.task else { return }
        TaskController.shared.toggleIsComplete(for: task)
        cell.updateViews()
    }
}
