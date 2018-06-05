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
    case Daily = "Tous les jours"
    case Weekly = "Toutes les semaines"
    case Monthly = "Tous les mois"
    case TwoWeekly = "Toutes les deux semaines"
    case Yearly = "Tous les ans"
    case Once = "Jamais"
    
}

enum IconAsset : String{
    case bath
    case Beer
    case brush_teeth
    case eat
    case sleep
    case work
    var image : UIImage {
        return UIImage(named: self.rawValue)!
    }
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
