//
//  TicketDetailCell.swift
//  Proyecto2trimestre
//
//  Created by juandi on 26/02/2018.
//  Copyright © 2018 juandi. All rights reserved.
//

import UIKit

class TicketDetailCell: UITableViewCell {

    
    
    @IBOutlet weak var countProduct: UILabel!
    @IBOutlet weak var priceTicket: UILabel!
    @IBOutlet weak var nameTicket: UILabel!
    @IBOutlet weak var imageTicket: UIImageView!
    
    
    @IBAction func deleteTicket(_ sender: Any) {
       
    }
    @IBAction func editTicket(_ sender: Any) {
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
