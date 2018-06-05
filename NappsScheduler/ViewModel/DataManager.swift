//
//  DataManager.swift
//  NappsScheduler
//
//  Created by Thomas Chaboud on 05/06/2018.
//  Copyright © 2018 Thomas Chaboud. All rights reserved.
//

import Foundation
import CoreData
import Firebase
import FirebaseFirestore

class DataManager{
    
    public var db: Firestore!
    
    static let sharedInstance = DataManager()
    
    var documentDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    var dataFileUrl: URL {
        return documentDirectory.appendingPathComponent("tasks").appendingPathExtension("json")
    }
    

    var cachedTasks = [Task]()
    var cachedPlanning : Planning? = nil
    
    private init() {
        initFirebase()
        // loadData()
    }
    
    private func initFirebase(){
        let settings = FirestoreSettings()
        settings.areTimestampsInSnapshotsEnabled = true
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
   }

    
    func saveTasks(tasksId: Array<DocumentReference>){
        var tasks = Array<Task>()
        for taskId in tasksId {
            print("CHEVRE \(taskId.path)")
            var path = taskId.path.components(separatedBy: "/")
            let docRef = db.collection(path[0]).document(path[1])
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    //let task = Task(taskName: document.data()!["taskName"] as! String)
                    tasks.append(Task(data: document.data()!, id: path[1]))
                    //print("Document data: \(dataDescription)")
                } else {
                    print("Document does not exist")
                }
            }
        }
        save(tasks: tasks)
    }
    
    func getPlanning(planningId: String? = "S9qp9mdbY2bCSylmpa7Q"){
        let planningRef = db.collection("Planning").document(planningId!)
       
        planningRef.getDocument { (document, error) in
        if let document = document, document.exists {
            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
            self.cachedPlanning = Planning(data: document.data()!, id: planningId!)
            print("Document data: \(dataDescription)")
        } else {
            print("Document does not exist")
        }
        }

        
    }
    
    
    func save(tasks: Array<Task>){
        self.cachedTasks = tasks
        print(cachedTasks.count)
        if(cachedTasks.count > 1){
            print(cachedTasks[0].taskName)
        }
    }
}
