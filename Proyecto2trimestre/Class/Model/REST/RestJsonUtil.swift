//
//  RestJsonUtil.swift
//  Proyecto2trimestre
//
//  Created by juandaniel on 01/03/2018.
//  Copyright © 2018 juandi. All rights reserved.
//

import Foundation
class RestJsonUtil{
    
    static func dictToJson(dic: [String:Any]) -> Data? {
        guard let json = try? JSONSerialization.data(withJSONObject: dic as Any, options: []) else {
            return nil
        }
        return json
    }
    
    static func jsonToDict(json: Data) -> [String: Any]? {
        guard let diccionario = try? JSONSerialization.jsonObject(with: json, options: []) as? [String: Any] else {
            return nil
        }
        return diccionario
    }
}
