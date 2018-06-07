//
//  ViewController.swift
//  NappsScheduler
//
//  Created by Thomas Chaboud on 30/05/2018.
//  Copyright © 2018 Thomas Chaboud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var selectedDate: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Planning"
        DataManager.sharedInstance
        self.navigationController?.navigationBar.isTranslucent=false
        self.view.backgroundColor=Style.bgColor
        
        view.addSubview(calenderView)
        calenderView.delegate = self
        calenderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 140).isActive=true
        calenderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive=true
        calenderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive=true
        calenderView.heightAnchor.constraint(equalToConstant: 365).isActive=true
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calenderView.myCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    @objc func rightBarBtnAction(sender: UIBarButtonItem) {
        self.view.backgroundColor=Style.bgColor
        //calenderView.changeTheme()
    }
    
    let calenderView: CalendarView = {
        let v=CalendarView()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addAction(_ sender: Any) {
        
            let alertController = UIAlertController(title: "Ajout tâche", message: "Quel type de tâche souhaitez vous créer ?", preferredStyle: .actionSheet)
        
            let normalTaskAction = UIAlertAction(title: "Tâche normale", style: .default, handler: { (action) in
                self.performSegue(withIdentifier: "FromCalendarToTask", sender: nil)
            })
            let taskInstantaneAction = UIAlertAction(title: "Message Instantané", style: .default, handler: { (action) in
                self.performSegue(withIdentifier: "FromCalendarToInstantMessage", sender: nil)
            })
            let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: { (action) in
                
            })
        
            alertController.addAction(normalTaskAction)
            alertController.addAction(taskInstantaneAction)
            alertController.addAction(cancel)
            present(alertController, animated: true, completion: nil)
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showListTasks") {
            let segueDestination = segue.destination as? ListTasksViewController
            segueDestination?.viewModel.fillCurrentDayTasks(tasks: DataManager.sharedInstance.cachedTasks)
            segueDestination?.navigationItem.title = selectedDate
        }
        if segue.identifier == "FromCalendarToTask"{
            let navController = segue.destination as? UINavigationController
            let destination = navController?.topViewController as? TaskViewController
            destination?.nav = NavContext.newFromCalendar
            destination?.viewModel.task = nil
        }
    }
    
}

extension ViewController : CalendarViewDelegate{
    func didSelectedDate(day: String) {
        selectedDate = day + " " + "\(calenderView.monthView.monthsArr[calenderView.currentMonthIndex - 1])" + " " + "\(calenderView.currentYear)"
        performSegue(withIdentifier: "showListTasks", sender: nil)
    }
    
    
}

