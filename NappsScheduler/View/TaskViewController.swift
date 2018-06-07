//
//  TaskViewController.swift
//  NappsScheduler
//
//  Created by Thomas Chaboud on 31/05/2018.
//  Copyright © 2018 Thomas Chaboud. All rights reserved.
//

import UIKit
import Firebase

enum NavContext {
    case newFromList
    case newFromCalendar
    case edit
}

class TaskViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var imageTableViewCell: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateDatePicker: UIDatePicker!
    @IBOutlet weak var recurrenceLabel: UILabel!
    
    var icon : IconAsset = IconAsset.work
    var recurrence : Frequency = Frequency.Once
    var needNotif : Bool = false
    var delegate : TaskViewModelDelegate?
    let viewModel =  TaskViewModel.sharedInstance
    var nav: NavContext?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        if let taskToEdit = viewModel.task{
            self.navigationItem.title = "ÉDITER UNE TÂCHE"
            self.nameLabel.text = taskToEdit.taskName
            self.imageTableViewCell.image = UIImage(named: taskToEdit.imgURL!)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.short
            dateFormatter.timeStyle = DateFormatter.Style.short
            dateFormatter.locale = Locale(identifier: "FR-fr")
            dateLabel.text = dateFormatter.string(from: (taskToEdit.date?.dateValue())!)
            recurrenceLabel.text = taskToEdit.frequency?.rawValue
            
        }else{
        imageTableViewCell.image = UIImage(named: icon.rawValue)
        recurrenceLabel.text = Frequency.Once.rawValue
        }
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.locale = Locale(identifier: "FR-fr")
        
        let strDate = dateFormatter.string(from: dateDatePicker.date)
        dateLabel.text = strDate
        
    }
    
    @IBAction func cancelAction(){
        viewModel.task = nil
        if self.nav == NavContext.newFromCalendar{
            self.dismiss(animated: true, completion: nil)
        }
        else{
            _ = navigationController?.popViewController(animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func done(_ sender: Any) {
        if self.viewModel.task != nil{
            self.viewModel.task?.taskName = nameLabel.text
            self.viewModel.task?.imgURL = icon.rawValue
            self.viewModel.task?.date = Timestamp(date: dateDatePicker.date)
            self.viewModel.task?.needANotif = needNotif
            self.viewModel.task?.frequency = recurrence
            delegate?.taskViewModel(TaskViewModel.sharedInstance, didFinishEditingItem: self.viewModel.task!)
        }else{
        let task = Task(date: Timestamp(date: dateDatePicker.date), frequency: recurrence, imgURL: icon.rawValue, isChecked: false, needANotif: needNotif, taskName: nameLabel.text)
        DataManager.sharedInstance.addTask(task: task)
        }
        if nav == NavContext.newFromCalendar{
            self.viewModel.task = nil
            self.dismiss(animated: true, completion: nil)
            
        }else{
            self.viewModel.task = nil
            self.navigationController?.popToRootViewController(animated: true)
            
        }
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.locale = Locale(identifier: "FR-fr")
        self.navigationItem.rightBarButtonItem?.isEnabled = true
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
    
    func recurrenceChange(newFrequency: Frequency){
        self.recurrence = newFrequency
        self.recurrenceLabel.text = self.recurrence.rawValue
    }
    
    @IBAction func textfieldEditing(_ textField: UITextField) {
        self.navigationItem.rightBarButtonItem?.isEnabled = !(textField.text!.isEmpty)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }

}

extension TaskViewController : AddImageViewControllerDelegate
{
    func didSelectNewIcon(newIcon: IconAsset) {
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.icon = newIcon
        self.imageTableViewCell.image = UIImage(named: self.icon.rawValue)
    }
    
    
}






