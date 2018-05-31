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
    
    var id : Int?
    var firstName: String?
    var lastName: String?
    var mail: String?
    var idAutist: Int?
    
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id<-map["id"]
        firstName<-map["firstName"]
        lastName<-map["lastName"]
        mail<-map["mail"]
        idAutist<-map["autisteId"]
    }
    
    
    
}
