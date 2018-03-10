//
//  ViewController.swift
//  Proyecto2trimestre
//
//  Created by juandi on 01/02/2018.
//  Copyright © 2018 juandi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, OnHttpResponse {
    
    @IBOutlet weak var tfUsuario: UITextField!
    @IBOutlet weak var tfContraseña: UITextField!
    
    func onErrorReceivingData(message: String) {
        
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //inicializamos el spinner
    //var activityIndicator:UIActivityIndicatorView=UIActivityIndicatorView()
    
    @IBOutlet weak var btnEnter: UIButton!
    
    func onDataReceived(data: Data) {
        guard let diccionario = RestJsonUtil.jsonToDict(json: data)else{
            activityIndicator.stopAnimating()
            btnEnter.isEnabled = true;
            return
        }
        
        if(diccionario["token"] != nil){
            let longToken = diccionario["token"].debugDescription
            var token = longToken.split(separator: "º")
            LogData.setToken(token: token[1].description)
            
            if(diccionario["families"] != nil){
                let longFamilies = diccionario["families"].debugDescription
                var families = longFamilies.split(separator: "-")
                families.remove(at: 0)
                families.remove(at: families.count-1)
                for field in stride(from: 0, through: families.count-1, by: 3) {
                    Cache.addFamily(family: Family(id: Int.init(families[field+1])!,family: families[field].description))
                }
                
                guard let cliente = ClienteHttp(target:"product" , responseObject:self, auth:("Bearer "+LogData.getToken())) else{
                    activityIndicator.stopAnimating()
                    btnEnter.isEnabled = true;
                    return
                }
                cliente.request()
                
            }else if(diccionario["products"] != nil){
                let longProducts = diccionario["products"].debugDescription
                var products = longProducts.split(separator: "-")
                products.remove(at: 0)
                products.remove(at: products.count-1)
                for field in stride(from: 0, through: products.count-1, by: 6) {
                    Cache.addProduct(product: Product(id: Int(products[field+4])!, family: Int(products[field+3])!, name: products[field].description, description: products[field+2].description, price: Double(products[field+1])!))
                    
                }
                guard let cliente = ClienteHttp(target:"ticket" , responseObject:self, auth:("Bearer "+LogData.getToken())) else{
                    activityIndicator.stopAnimating()
                    btnEnter.isEnabled = true;
                    return
                }
                cliente.request()
            }else if(diccionario["ticket"] != nil){
                let longTicket = diccionario["ticket"].debugDescription
                var tickets = longTicket.split(separator: "º")
                tickets.remove(at: 0)
                tickets.remove(at: tickets.count-1)
                for field in stride(from: 0, through: tickets.count-1, by: 4) {
                    var aux = tickets[field+1].split(separator: " ")
                    let fecha = aux[0]
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let date = dateFormatter.date(from:String(aux[0]))!
                    let calendar = Calendar.current
                    let components = calendar.dateComponents([.year, .month, .day], from: date)
                    let finalDate = calendar.date(from:components)
                    
                    
                    Cache.addTicket(ticket: Ticket(id: Int(tickets[field])!, date: finalDate!, idmember: Int(tickets[field+2])!))
                    
                }
                let longDetail = diccionario["ticketdetail"].debugDescription
                var details = longDetail.split(separator: "-")
                details.remove(at: 0)
                details.remove(at: details.count-1)
                for field in stride(from: 0, through: details.count-1, by: 6) {
                    let detail = TicketDetail(id: Int(details[field])!, idTicket: Int(details[field+1])!, price: Double(details[field+4])!, idproduct: Int(details[field+2])!, quantify: Int(details[field+3])!)
                    for ticket in Cache.getTickets(){
                        if detail.id_ticket==ticket.id{
                            ticket.addDetail(detail: detail)
                        }
                    }
                }
                performSegue(withIdentifier: "LoginToFamily", sender: self)
            }
        }
    }
    
    @IBAction func BtnEnter(_ sender: AnyObject) {
        activityIndicator.self.center=self.view.center
        activityIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        btnEnter.isEnabled = false
        
        LogData.setUser(log: tfUsuario.text!)
        LogData.setPass(pass: tfContraseña.text!)
        guard let cliente = ClienteHttp(target:"family" , responseObject:self, auth:("Basic "+LogData.getBase64())) else{
            return
        }
        cliente.request()
        
        
    }
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        activityIndicator.stopAnimating()
        //disableBtnEnter.isEnabled = true;
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped=true;
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        //Borde de selección
        cell?.layer.borderColor = UIColor.gray.cgColor
        cell?.layer.borderWidth = 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        //Deseleccionar borde
        cell?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.layer.borderWidth = 0.5
    }
}
