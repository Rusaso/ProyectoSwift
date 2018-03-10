//
//  LogData.swift
//  Proyecto2trimestre
//
//  Created by juandi on 27/02/2018.
//  Copyright © 2018 juandi. All rights reserved.
//

import Foundation
class LogData{
    static var user:String = ""
    static var pass:String = ""
    static var token:String = ""
    
    static func setUser(log:String){
        self.user=log
    }
    
    static func setToken(token:String){
        self.token=token
    }
    
    static func getToken()->String{
        return self.token
    }
    
    static func setPass(pass:String){
        self.pass=pass
    }
    
    static func getBase64()->String{
        guard let log=Base64.encode(str:user+":"+pass)else{
            print("campos vacia")
            return ""
        }
        return log
    }
}
