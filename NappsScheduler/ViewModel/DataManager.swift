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
    var ref : DocumentReference?
    

    
    private init() {
        initFirebase()
        addListener(collection: "Planning", document: "S9qp9mdbY2bCSylmpa7Q") //ajout du listener
        // loadData()
    }
    
    //AJOUT D'UN LISTENER SUR UNE COLLECTION FIREBASE
    func addListener(collection: String, document: String){
        self.db.collection(collection).document(document)
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                self.getPlanning()
        }
    }
    
    private func initFirebase(){
        let settings = FirestoreSettings()
        settings.areTimestampsInSnapshotsEnabled = true
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
   }
    
    func getPlanning(planningId: String? = "S9qp9mdbY2bCSylmpa7Q"){
        let planningRef = db.collection("Planning").document(planningId!)
       
        planningRef.getDocument { (document, error) in
        if let document = document, document.exists {
            self.cachedTasks = [Task]()
            //_ = document.data().map(String.init(describing:)) ?? "nil"
            self.cachedPlanning = Planning(data: document.data()!, id: planningId!)
            self.cachedTasks.removeAll()
            
            for task in (self.cachedPlanning?.task)!{
                self.getTask(path: task.documentID)
                print(self.cachedTasks)
                
            }
            print("Document data: Spaghett")
        } else {
            print("Document does not exist")
        }
            
        }

    }
    
    func getTask(path: String){
        //let planningRef = db.collection("Task").document(path)
        
        let planningRef = db.collection("Task")
        planningRef.document(path).getDocument { (document, error) in
            if let document = document, document.exists {
                //_ = document.data().map(String.init(describing:)) ?? "nil"
                self.cachedTasks.append(Task(data: document.data()!, id: path))
          //      print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
        
        planningRef.order(by: "taskName")
    }
    
    func addTask(task : Task){
        db.collection("Task").document(task.taskId!).setData([
            "date": task.date,
            "frequency": task.frequency?.rawValue,
            "imgURL": task.imgURL,
            "isChecked" : task.isChecked,
            "needANotif" : task.needANotif,
            "taskName" : task.taskName ], merge: true)
        
        ref = db.collection("Task").document(task.taskId!)
        cachedPlanning?.task?.append(ref!)
        db.collection("Planning").document((cachedPlanning?.id)!).updateData([
            "tasksId": cachedPlanning?.task
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
        
        
        
    }
    
    func modifTask(task : Task){
        db.collection("Task").document(task.taskId!).setData([
            "date": task.date,
            "frequency": task.frequency?.rawValue,
            "imgURL": task.imgURL,
            "isChecked" : task.isChecked,
            "needANotif" : task.needANotif,
            "taskName" : task.taskName ], merge: true)
    }
}
