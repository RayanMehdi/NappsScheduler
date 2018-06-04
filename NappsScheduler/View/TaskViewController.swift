//
//  TaskViewController.swift
//  NappsScheduler
//
//  Created by Thomas Chaboud on 31/05/2018.
//  Copyright © 2018 Thomas Chaboud. All rights reserved.
//

import UIKit

class TaskViewController: UITableViewController {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var imageTableViewCell: UITableViewCell!
    @IBOutlet weak var recurrenceTableViewCell: UITableViewCell!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: dateDatePicker.date)
        dateLabel.text = strDate
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
