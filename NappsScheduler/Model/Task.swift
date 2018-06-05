//
//  Task.swift
//  NappsScheduler
//
//  Created by Thomas Chaboud on 30/05/2018.
//  Copyright © 2018 Thomas Chaboud. All rights reserved.
//

import Foundation
import Firebase

class Task{
    var date : Timestamp?
    var frequency : String?
    var imgURL : String?
    var isChecked : Bool?
    var needANotif : Bool?
    var taskName : String?
    var taskId : String?
    
    init(date: Timestamp?, frequency: String?, imgURL: String?, isChecked: Bool?, needANotif: Bool?, taskName: String? ) {
        self.date = date
        self.frequency = frequency
        self.imgURL = imgURL
        self.isChecked = isChecked
        self.needANotif = needANotif
        self.taskName = taskName
    }
    
    init(taskId: String, taskName: String,imgURL: String ) {
        self.imgURL = imgURL
        self.taskName = taskName
        self.taskId = taskId
    }
    init(data: [String: Any?], id: String) {
        self.date = data["date"] as? Timestamp
        self.frequency = data["frequency"] as? String
        self.imgURL = data["imgURL"] as? String
        self.isChecked = data["isChecked"] as? Bool
        self.needANotif = data["needANotif"] as? Bool
        self.taskName = data["taskName"] as? String
        self.taskId = id
    }
    init(taskName: String) {
        self.taskName = taskName
    }
    
}
