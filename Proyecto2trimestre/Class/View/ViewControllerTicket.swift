//
//  ViewControllerTicket.swift
//  Proyecto2trimestre
//
//  Created by juandi on 26/02/2018.
//  Copyright © 2018 juandi. All rights reserved.
//

import UIKit

class ViewControllerTicket: UIViewController,UITableViewDataSource,UITableViewDelegate, OnHttpResponse ,UITextViewDelegate{
    
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var NameTicket: UILabel!
    @IBOutlet weak var labelTotal: UILabel!
    var countProduct :UITextField?
    
    func onDataReceived(data: Data) {
        guard let diccionario = RestJsonUtil.jsonToDict(json: data)else{
            return
        }
        
        let id = diccionario["userid"] as! String
        
        self.inserticket(id)
        
        let lastidticket = diccionario["lastticket"] as! String
        print(lastidticket)
        var idticketreal:Int = Int(lastidticket)!
        idticketreal += 1
        print(idticketreal)
        
        self.insertticketdetail(idticketreal)
        
        Cache.ticketDetail = []
        myTable.reloadData()
    }
    
    func onErrorReceivingData(message: String) {
    }
    
    func inserticket(_ id:String){
        //ticket grande
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var result = formatter.string(from: date)
        var hora = result
        formatter.dateFormat = "hh:mm:ss"
        result = formatter.string(from: date)
        hora += " " + result
        
        let someDict:[String:Any] = ["ticket":["idmember":id, "date":hora]]
        
        guard let ticketcliente = ClienteHttp(target:"ticket" , responseObject:self,"POST", someDict, auth:("Bearer "+LogData.getToken())) else{
            print("error")
            return
        }
        ticketcliente.request();
    }
    
    func insertticketdetail(_ idticketreal:Int){
        //ticket detail
        print("count ", Cache.ticketDetail.count)
        for c in Cache.ticketDetail{
            print("insertado")
            let someDict2:[String:Any] = ["ticketdetail":["idticket":idticketreal, "idproduct":c.idproduct, "quantity":c.quantify, "price":c.price]]
            guard let ticketdetailcliente = ClienteHttp(target:"ticket" , responseObject:self,"POST", someDict2, auth:("Bearer "+LogData.getToken())) else{
                print("error")
                return
            }
            ticketdetailcliente.request();
        }
    }

 
    
    
    
    
   
    
    @IBAction func refresh(_ sender: Any) {
        self.myTable.reloadData()
        var priceTotal:Double = 0.00
        
        print("viewDidload,"+Cache.ticketDetail.count.description)
        
        for t in Cache.ticketDetail{
            priceTotal += t.price * Double(t.quantify)
            
        }
        
        
        labelTotal.text=priceTotal.description+"€"
    }
    
    //funcion imprimir
    
    @IBAction func btnImprimir(_ sender: Any) {
        guard let lastticket = ClienteHttp(target:"lastticket" , responseObject:self, auth:("Basic "+LogData.getBase64())) else{
            print("error")
            return
        }
        lastticket.request()
    }
    
    
    //viewdidLoad
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var priceTotal:Double = 0.00
        
        for t in Cache.ticketDetail{
            priceTotal += t.price * Double(t.quantify)
            
        }
        
       
       labelTotal.text=priceTotal.description+"€"
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.myTable.reloadData()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.myTable.reloadData()        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func tableView(_ mytable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cache.ticketDetail.count
    }
    
    
    
    //creacion de la celda
    
    func tableView(_ mytable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=mytable.dequeueReusableCell(withIdentifier: "cellTicket") as! TicketDetailCell
        
        let product = Cache.getProducts()
        
        for p in product{
            if p.id == Cache.ticketDetail[indexPath.row].idproduct{
                cell.nameTicket.text = p.name_product
                cell.priceTicket.text = p.price.description+"€"
                cell.imageTicket.image = p.image
                print(product[indexPath.row].id)
            }
        }
        cell.countProduct.text = Cache.ticketDetail[indexPath.row].quantify.description
        return cell
    }
    var idTicket = Int()
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            Cache.ticketDetail.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        idTicket = Cache.ticketDetail[indexPath.row].idproduct
        let alert = UIAlertController(title: "MODIFICAR LA CANTIDAD DE PRODUCTO", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: countProduct)
        let okaction=UIAlertAction(title:"AÑADIR", style: .default, handler: {action in self.okHanler()})
        
        let cancelAction=UIAlertAction(title:"CANCELAR", style: .default, handler: nil)
        
        alert.addAction(okaction)
        alert.addAction(cancelAction)
        self.present(alert,animated: true)

    }
    func countProduct(text:UITextField!){
        countProduct = text
        countProduct?.placeholder = "0 - 10"
    }
    func okHanler(){
        var count:Int = Int((countProduct?.text!)!)!
        
        if count > 0 && count < 10 {
           
            for t in Cache.ticketDetail{
                if idTicket == t.idproduct{
                    t.quantify = count
                }
            }
            
            
            
        }
    }
    
   
}
