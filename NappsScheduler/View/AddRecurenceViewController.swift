//
//  AddReccurenceViewController.swift
//  NappsScheduler
//
//  Created by iem on 04/06/2018.
//  Copyright © 2018 Thomas Chaboud. All rights reserved.
//

import UIKit

class AddRecurenceViewController: UITableViewController {

    var delegate: TaskViewController!
    var listRecurrence: Array<Frequency> = [Frequency.Once, Frequency.Daily, Frequency.Monthly, Frequency.Weekly, Frequency.TwoWeekly, Frequency.Yearly]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.oui
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listRecurrence.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recurrenceCell", for: indexPath)
        cell.textLabel?.text = listRecurrence[indexPath.row].rawValue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.recurrenceChange(newFrequency: listRecurrence[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }

}
