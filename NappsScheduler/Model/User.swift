//
//  User.swift
//  NappsScheduler
//
//  Created by Thomas Chaboud on 30/05/2018.
//  Copyright © 2018 Thomas Chaboud. All rights reserved.
//

import Foundation


class User {
    
    var id : String?
    var firstName: String?
    var lastName: String?
    var mail: String?
    var idAutist: String?
    
    
    
    init(id: String?, firstName: String?,lastName: String?, mail: String?, idAutist: String? ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.mail = mail
        self.idAutist = idAutist
    }
    
}
