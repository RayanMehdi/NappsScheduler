//
//  Planning.swift
//  NappsScheduler
//
//  Created by Thomas Chaboud on 04/06/2018.
//  Copyright © 2018 Thomas Chaboud. All rights reserved.
//

import Foundation
import ObjectMapper
import Firebase


class Planning {
    
    //MARK: - Var
    var id: String?
    var autisteId: DocumentReference?
    var responsableId: [DocumentReference]?
    var task: [DocumentReference]?
    
    init(id: String?, autisteId: DocumentReference?, responsableId: [DocumentReference]?, task: [DocumentReference]?) {
        self.id = id
        self.autisteId = autisteId
        self.responsableId = responsableId
        self.task = task
    }
    
    init(data: [String: Any?], id: String) {
        self.id = id
        self.autisteId = data["autisteId"] as? DocumentReference
        self.responsableId = data["responsableId"] as? [DocumentReference]
        self.task = data["tasksId"] as? [DocumentReference]
    }


}

