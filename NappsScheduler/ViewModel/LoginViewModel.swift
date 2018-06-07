//
//  LoginViewModel.swift
//  NappsScheduler
//
//  Created by iem on 07/06/2018.
//  Copyright © 2018 Thomas Chaboud. All rights reserved.
//

import Foundation
class LoginViewModel {

    static let sharedInstance = LoginViewModel()
    
    private init() {}
    
    func isLoginEmpty(username:String?, password:String?)->Bool{
        if (username?.isEmpty)! || (password?.isEmpty)!{
            return true
        }
        return false
    }
    
    func isLoginValid(username:String?, password:String?)->Bool{
        if username != "test@test.com"{
            return false
        }
        if password != "test"{
            return false
        }
        return true
    }
}


