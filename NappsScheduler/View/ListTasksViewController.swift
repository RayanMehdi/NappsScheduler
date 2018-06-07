//
//  ListTasksViewController.swift
//  NappsScheduler
//
//  Created by iem on 04/06/2018.
//  Copyright © 2018 Thomas Chaboud. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskTimeLabel: UILabel!
}

class ListTasksViewController: UITableViewController {
    
    var dateTasks: String!
    var viewModel = ListTasksViewModel.sharedInstance
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.sortDayTasks()
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        print("Spaghett")
        navigationController?.title = dateTasks
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.selectedDayTask.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let calendar = Calendar.current
        let dateFromTimestamp = viewModel.selectedDayTask[indexPath.row].date?.dateValue()
        let hour = calendar.component(.hour, from: dateFromTimestamp!)
        let minutes = calendar.component(.minute, from: dateFromTimestamp!)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskTableViewCell") as! TaskTableViewCell
        cell.taskNameLabel.text = viewModel.selectedDayTask[indexPath.row].taskName
        
        
        cell.taskTimeLabel.text = (minutes < 10) ? "\(hour):0\(minutes)" : "\(hour):\(minutes)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "FromListToTask", sender: tableView.cellForRow(at: indexPath))
    }
    
 
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FromListToTask"{
            let destinationNavigationController = segue.destination as! TaskViewController
            destinationNavigationController.delegate = self
            let tv = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: tv)
            destinationNavigationController.viewModel.task = viewModel.selectedDayTask[(indexPath?.row)!]
            destinationNavigationController.nav = NavContext.edit
            
        }
        if segue.identifier == "newTask"{
            let destinationNavigationController = segue.destination as! TaskViewController
            destinationNavigationController.delegate = self
            destinationNavigationController.nav = NavContext.newFromList
            destinationNavigationController.viewModel.task = nil
        }
    }

}

extension ListTasksViewController : TaskViewModelDelegate
{
    func taskViewModel(_ viewModel: TaskViewModel, didFinishEditingItem item: Task) {
        let index = self.viewModel.selectedDayTask.index(where:{ $0 == item })
        self.viewModel.selectedDayTask[index!].taskName = item.taskName
        let calendar = Calendar.current
        let dateFromTimestamp = self.viewModel.selectedDayTask[index!].date?.dateValue()
        let hour = calendar.component(.hour, from: dateFromTimestamp!)
        let minutes = calendar.component(.minute, from: dateFromTimestamp!)
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "taskTableViewCell", for: IndexPath(row: index!, section: 0)) as! TaskTableViewCell
        cell.taskNameLabel.text = self.viewModel.selectedDayTask[index!].taskName
        cell.taskTimeLabel.text = (minutes < 10) ? "\(hour):0\(minutes)" : "\(hour):\(minutes)"
        DataManager.sharedInstance.modifTask(task: item)

        tableView.reloadData()
    }
    
    
}
