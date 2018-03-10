//
//  Product.swift
//  Proyecto2trimestre
//
//  Created by juandi on 27/02/2018.
//  Copyright © 2018 juandi. All rights reserved.
//

import UIKit
import Foundation

class Product{
    
    let id: Int
    let family : Int
    let name_product: String
    let description: String
    let price: Double
    var image:UIImage?
    var imageDetail:UIImage?
    
    
    
    init(id:Int,family: Int,name: String,description: String,price: Double){
        self.id = id
        self.family = family
        self.name_product = name
        self.description = description
        self.price = price
        downloadImgProduct()
        downloadImgProductDetail()
    }
    func downloadImgProduct(){
        
        let urlImagen = "https://proyecto2-yusaso.c9users.io//IosPanaderia/img/\(self.id).png"
        if let url = URL(string: urlImagen) {
            let cola = DispatchQueue(label: "bajar.imagen",
                                     qos: .default,
                                     attributes: .concurrent)
            cola.async {
                if let data = try? Data(contentsOf: url),
                    let imagen = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = imagen
                        
                        
                    }
                }
            }
        }
        
    }
    func downloadImgProductDetail(){
        
        let urlImagen = "https://proyecto2-yusaso.c9users.io//IosPanaderia/img/\(self.id).jpg"
        if let url = URL(string: urlImagen) {
            let cola = DispatchQueue(label: "bajar.imagen",
                                     qos: .default,
                                     attributes: .concurrent)
            cola.async {
                if let data = try? Data(contentsOf: url),
                    let imagen = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageDetail = imagen
                        
                        
                        
                    }
                }
            }
        }
        
    }
}
