//
//  TaskViewModel.swift
//  NappsScheduler
//
//  Created by iem on 06/06/2018.
//  Copyright © 2018 Thomas Chaboud. All rights reserved.
//

import Foundation

class TaskViewModel {
    
    //MARK: - properties
    var task: Task?
    
    static let sharedInstance = TaskViewModel()
    
    private init() {}
}

//MARK: - TaskViewModelDelegate

protocol TaskViewModelDelegate: class {
    func taskViewModel(_ viewModel: TaskViewModel, didFinishEditingItem item: Task)
}
