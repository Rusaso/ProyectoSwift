//
//  OnHttpResponse.swift
//  Proyecto2trimestre
//
//  Created by juandaniel on 01/03/2018.
//  Copyright © 2018 juandi. All rights reserved.
//

import Foundation
protocol OnHttpResponse {
    func onDataReceived(data: Data)
    func onErrorReceivingData(message: String)
}
