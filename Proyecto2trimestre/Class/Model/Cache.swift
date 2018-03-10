//
//  Cache.swift
//  Proyecto2trimestre
//
//  Created by juandaniel on 01/03/2018.
//  Copyright © 2018 juandi. All rights reserved.
//
import UIKit
import Foundation
class Cache{
    private static var families = [Family]()
    private static var products = [Product]()
    private static var tickets = [Ticket]()
    public static var ticketDetail:[TicketDetail] = [TicketDetail]()
    
    static func addFamily(family: Family){
        self.families.append(family)
    }
    
    static func addProduct(product: Product){
        self.products.append(product)
    }
    
    static func addTicket(ticket: Ticket){
        self.tickets.append(ticket)
    }
    
    static func getFamilies()->[Family]{
        return(self.families)
    }
    
    static func getProducts()->[Product]{
        return(self.products)
    }
    static func getTickets()->[Ticket]{
        return(self.tickets)
    }
    static func getNameFamilyByProduct( id:Int)-> String{
        var name_family:String=""
        for f in families{
            if(f.id==id){
                name_family=f.family
            }
        }
        return name_family
    }
}
