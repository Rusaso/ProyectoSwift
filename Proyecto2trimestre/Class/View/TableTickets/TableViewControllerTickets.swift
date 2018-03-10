//
//  TableViewControllerTickets.swift
//  Proyecto2trimestre
//
//  Created by juandi on 06/03/2018.
//  Copyright © 2018 juandi. All rights reserved.
//

import UIKit

class TableViewControllerTickets: UITableViewController {
    
    
    @IBOutlet var myTable: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    private var ticket = Cache.getTickets()[0]
    private var tickets = Cache.getTickets()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (tableView.tag == 100){
            return Cache.getTickets().count
        }else {
            return ticket.ticketDetails.count
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch(segmentedControl.selectedSegmentIndex)
        {
        case 0:
            
            tickets = tickets.sorted(by: { $0.id > $1.id })
            print("orden ID")
            break
        case 1:
            tickets = tickets.sorted(by: { $0.id_member > $1.id_member })
            print("orden miembro")
            break
            
        case 2:
            tickets = tickets.sorted(by: { $0.date > $1.date })
            print("orden fecha")
            break
        default:
            break
        }
        if (tableView.tag == 100){
            print("Tag 100")
            let identifier = "TableViewCellFuera"
            guard  let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TableViewCellFuera
                else {
                    fatalError("The dequeued cell is not an instance of MealTableViewCell.")
            }
            ticket=tickets[indexPath.row]
            cell.tfID.text = ticket.id.description
            cell.tfDate.text = ticket.date.description
            cell.tfMember.text = ticket.id_member.description
            var total=0.00
            for detail in ticket.ticketDetails{
                total += detail.price * Double(detail.quantify)
            }
            cell.tfTotal.text = total.description
            return cell
        }else {
            print("Tag 1")
            let identifier = "TableViewCellDentro"
            guard  let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TableViewCellDentro
                else {
                    fatalError("The dequeued cell is not an instance of MealTableViewCell.")
            }
            let detail = ticket.ticketDetails[indexPath.row]
            cell.tfProducto.text = detail.idproduct.description
            cell.tfCantidad.text = detail.quantify.description
            cell.tfPrecio.text = detail.price.description
            return cell
            
        }
        
    }
    
    @IBAction func segmentedControlChanged(_ sender: Any) {
        myTable.reloadData()
    }
}
