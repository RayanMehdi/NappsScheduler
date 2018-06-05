//
//  TaskViewController.swift
//  NappsScheduler
//
//  Created by Thomas Chaboud on 31/05/2018.
//  Copyright © 2018 Thomas Chaboud. All rights reserved.
//

import UIKit
import Firebase

class TaskViewController: UITableViewController {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var imageTableViewCell: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateDatePicker: UIDatePicker!
    @IBOutlet weak var recurrenceLabel: UILabel!
    
    var icon : IconAsset = IconAsset.work
    var recurrence : Frequency = Frequency.Once
    var task : Task!
    var needNotif : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageTableViewCell.image = UIImage(named: icon.rawValue)
        recurrenceLabel.text = Frequency.Once.rawValue
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        let task = Task(date: Timestamp(date: dateDatePicker.date), frequency: recurrence, imgURL: icon.rawValue, isChecked: false, needANotif: needNotif, taskName: nameLabel.text)
        DataManager.sharedInstance.addTask(task: task)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.locale = Locale(identifier: "FR-fr")
        
        let strDate = dateFormatter.string(from: dateDatePicker.date)
        dateLabel.text = strDate
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddImage" {
            if let dest = segue.destination as? AddImageViewController{
                dest.delegate = self;
            }
        }
        else if segue.identifier == "showAddRecurrence" {
            if let dest = segue.destination as? AddRecurenceViewController{
                dest.delegate = self;
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.reuseIdentifier == "needNotifCell"{
                if cell.accessoryType == .checkmark {
                    cell.accessoryType = .none
                    needNotif = false
                } else {
                    cell.accessoryType = .checkmark
                    needNotif = true
                }
            }
        }
    }
    
    
    func iconChange(newIcon: IconAsset){
        self.icon = newIcon
        //self.imageTableViewCell.image = self.icon.image
        self.imageTableViewCell.image = UIImage(named: self.icon.rawValue)
    }
    
    func recurrenceChange(newFrequency: Frequency){
        self.recurrence = newFrequency
        self.recurrenceLabel.text = self.recurrence.rawValue
    }

}


