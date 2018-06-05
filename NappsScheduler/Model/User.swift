//
//  User.swift
//  NappsScheduler
//
//  Created by Thomas Chaboud on 30/05/2018.
//  Copyright © 2018 Thomas Chaboud. All rights reserved.
//

import Foundation
import ObjectMapper

class User : Mappable {
    
    var id : String?
    var firstName: String?
    var lastName: String?
    var mail: String?
    var idAutist: String?
    
    
    required init?(map: Map) {}
    
    init(id: String?, firstName: String?,lastName: String?, mail: String?, idAutist: String? ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.mail = mail
        self.idAutist = idAutist
    }
    
    func mapping(map: Map) {
        id<-map["id"]
        firstName<-map["firstName"]
        lastName<-map["lastName"]
        mail<-map["mail"]
        idAutist<-map["autisteId"]
    }
    
    
    
    
}
