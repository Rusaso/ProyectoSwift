//
//  TableViewCellFuera.swift
//  Proyecto2trimestre
//
//  Created by juandi on 06/03/2018.
//  Copyright © 2018 juandi. All rights reserved.
//

import UIKit

class TableViewCellFuera: UITableViewCell {

    
    @IBOutlet weak var TableDentro: UITableView!
    
    
    @IBOutlet weak var tfID: UILabel!
    @IBOutlet weak var tfMember: UITextField!
    
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var tfTotal: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
