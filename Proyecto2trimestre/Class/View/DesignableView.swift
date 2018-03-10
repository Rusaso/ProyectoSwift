//
//  DesignableView.swift
//  Proyecto2trimestre
//
//  Created by juandaniel on 01/03/2018.
//  Copyright © 2018 juandi. All rights reserved.
//

import UIKit

@IBDesignable class DesignableView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
            
        }
    }
   
}
