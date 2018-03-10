//
//  myCollectionCell.swift
//  Proyecto2trimestre
//
//  Created by juandi on 09/02/2018.
//  Copyright © 2018 juandi. All rights reserved.
//

import UIKit

class myCollectionCell: UICollectionViewCell {
      
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    
  
   
    
    

    public func drawShadow(){
        let layer = view.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
    }
}
