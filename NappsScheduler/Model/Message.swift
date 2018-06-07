//
//  Message.swift
//  NappsScheduler
//
//  Created by Thomas Chaboud on 07/06/2018.
//  Copyright © 2018 Thomas Chaboud. All rights reserved.
//

import Foundation
import Firebase

class Message{
    
    var messageId: String?
    var messageName: String?
    var imgUrl: String?
    
    init(messageId: String? = "zPe4zhDnFAUfllUaoIVl", messageName: String,imgURL: String ) {
        self.imgUrl = imgURL
        self.messageName = messageName
        self.messageId = messageId
    }
    
    
}
