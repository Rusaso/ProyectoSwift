//
//  Ticket.swift
//  Proyecto2trimestre
//
//  Created by juandi on 27/02/2018.
//  Copyright © 2018 juandi. All rights reserved.
//
import Foundation

class Ticket{
    
    let id:Int
    let date:Date
    let id_client:Int?=nil
    let id_member:Int
    var ticketDetails = [TicketDetail]()
    
    init(id : Int ,date: Date,idmember: Int){
        self.id = id
        self.date = date
        self.id_member = idmember
    }
    func addDetail(detail:TicketDetail) {
        ticketDetails.append(detail)
    }
}
