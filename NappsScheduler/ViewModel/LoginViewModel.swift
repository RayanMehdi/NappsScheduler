//
//  LoginViewModel.swift
//  NappsScheduler
//
//  Created by iem on 07/06/2018.
//  Copyright © 2018 Thomas Chaboud. All rights reserved.
//

import Foundation
class LoginViewModel {
    
    //MARK: - properties
    var username: String?
    var password: String?
    
    static let sharedInstance = TaskViewModel()
    
    private init() {}
}
