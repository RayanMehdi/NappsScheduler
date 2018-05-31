//
//  Task.swift
//  NappsScheduler
//
//  Created by Thomas Chaboud on 30/05/2018.
//  Copyright © 2018 Thomas Chaboud. All rights reserved.
//

import Foundation
import ObjectMapper

enum Frequency : String{
    case Daily
    case Weekly
    case Monthly
    case TwoWeekly
    case Yearly
    case Once
    
}

class Task: Mappable {
    
    var id: Int?
    var date: Date?
    var imgUrl: String?
    var isChecked: Bool?
    var needNotif: Bool?
    var frequency: Frequency?
    var name: String?
    
    
    required init?(map: Map) {}
    
     func mapping(map: Map) {
        id<-map["taskId"]
        date<-map["date"]
        imgUrl<-map["imgUrl"]
        isChecked<-map["isChecked"]
        needNotif<-map["sendANotif"]
        name<-map["taskName"]
        frequency <- (
            map["repeat"],
            TransformOf<Frequency, String>(
                fromJSON: {
                    guard $0 != nil else { return .Once }
                    return Frequency(rawValue: $0!)
            },
                toJSON: { $0?.rawValue }
            )
        )
        
    }
    
    
}
