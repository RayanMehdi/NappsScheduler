//
//  TaskInstantaneViewController.swift
//  NappsScheduler
//
//  Created by Thomas Chaboud on 07/06/2018.
//  Copyright © 2018 Thomas Chaboud. All rights reserved.
//

import UIKit

class TaskInstantaneViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var textFieldTaskInstantane: UITextField!

    @IBOutlet weak var iconImageView: UIImageView!
    
    var icon : IconAsset = IconAsset.work
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        iconImageView.image = UIImage(named: icon.rawValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        DataManager.sharedInstance.sendMessage(message: Message(messageName: textFieldTaskInstantane.text!, imgURL: icon.rawValue))
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddIcon" {
            if let dest = segue.destination as? AddImageViewController{
                dest.delegate = self;
            }
        }
    }
    
    @IBAction func textfieldEditing(_ textField: UITextField) {
        self.navigationItem.rightBarButtonItem?.isEnabled = !(textField.text!.isEmpty)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    
}

extension TaskInstantaneViewController : AddImageViewControllerDelegate
{
    func didSelectNewIcon(newIcon: IconAsset) {
        self.icon = newIcon
        self.iconImageView.image = UIImage(named: self.icon.rawValue)
    }
    
    
}
