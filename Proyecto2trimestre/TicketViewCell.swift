//
//  TicketViewCell.swift
//  Proyecto2trimestre
//
//  Created by juandi on 21/02/2018.
//  Copyright © 2018 juandi. All rights reserved.
//

import UIKit

class TicketViewCell: UITableViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func activation(_ sender: Any) {
    }
    
    @IBOutlet weak var totalTicket: UILabel!
    @IBOutlet weak var labelTotal: UILabel!
    @IBOutlet weak var nameTicket: UILabel!
    
    func setTableViewDelegateSource<D:UITableViewDelegate & UITableViewDataSource>(_ dataSourceDelegate:D , forRow row:Int){
        tableView.dataSource=dataSourceDelegate
        tableView.delegate=dataSourceDelegate
        tableView.reloadData()
    }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
