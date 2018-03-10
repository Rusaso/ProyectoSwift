//
//  TicketDetail.swift
//  Proyecto2trimestre
//
//  Created by juandi on 27/02/2018.
//  Copyright © 2018 juandi. All rights reserved.
//

import Foundation
class TicketDetail{
    let id:Int
    let id_ticket:Int
    let price:Double
    let idproduct:Int
    var quantify:Int
    
    init(id: Int,idTicket: Int,price:Double ,idproduct: Int,quantify: Int){
        self.id = id
        self.id_ticket = idTicket
        self.price = price
        self.idproduct = idproduct
        self.quantify = quantify
    }
}
