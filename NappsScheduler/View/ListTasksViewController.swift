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
        // Dispose of any resources that can be recreated.
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
    


    


}
