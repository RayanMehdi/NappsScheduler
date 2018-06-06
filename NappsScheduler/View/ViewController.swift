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
        self.title = "My Calender"
        DataManager.sharedInstance.getPlanning()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showListTasks") {
            let segueDestination = segue.destination as? ListTasksViewController
            segueDestination?.viewModel.fillCurrentDayTasks(tasks: DataManager.sharedInstance.cachedTasks)
            segueDestination?.navigationItem.title = selectedDate
        }
    }
    
}

extension ViewController : CalendarViewDelegate{
    func didSelectedDate(day: String) {
        selectedDate = day + " " + "\(calenderView.monthView.monthsArr[calenderView.currentMonthIndex - 1])" + " " + "\(calenderView.currentYear)"
        performSegue(withIdentifier: "showListTasks", sender: nil)
    }
    
    
}

