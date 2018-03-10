//
//  CatalogoCell.swift
//  Proyecto2trimestre
//
//  Created by juandi on 13/02/2018.
//  Copyright © 2018 juandi. All rights reserved.
//

import UIKit

class CatalogoCell: UICollectionViewCell {
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var LabelName: UILabel!
    @IBOutlet weak var LabelPrice: UILabel!
   
    
    public func drawShadow(){
        let layer = myView.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
        layer.cornerRadius = 15
        
    }
}
