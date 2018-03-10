//
//  TableViewCellDentro.swift
//  Proyecto2trimestre
//
//  Created by juandi on 06/03/2018.
//  Copyright © 2018 juandi. All rights reserved.
//

import UIKit

class TableViewCellDentro: UITableViewCell {

    @IBOutlet weak var tfProducto: UITextField!
    
    @IBOutlet weak var tfPrecio: UITextField!
    
    @IBOutlet weak var tfCantidad: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
