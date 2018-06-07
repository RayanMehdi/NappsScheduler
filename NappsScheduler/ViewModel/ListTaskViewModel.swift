//
//  ListTaskViewModel.swift
//  NappsScheduler
//
//  Created by iem on 06/06/2018.
//  Copyright © 2018 Thomas Chaboud. All rights reserved.
//

import Foundation


class ListTasksViewModel {
    //MARK: - properties
    
    var selectedDayTask = [Task]()
    
    static let sharedInstance = ListTasksViewModel()
    
    private init() {}
    
    
    //MARK: - Methods
    
    func fillCurrentDayTasks(tasks: [Task]){
        self.selectedDayTask = tasks
    }
    
    func sortDayTasks(){
        self.selectedDayTask = self.selectedDayTask.sorted(by: { ($0.date?.compare($1.date!))!.rawValue == -1 })
    }
}
