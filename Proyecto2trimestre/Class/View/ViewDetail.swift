//
//  ViewDetail.swift
//  Proyecto2trimestre
//
//  Created by juandi on 19/02/2018.
//  Copyright © 2018 juandi. All rights reserved.
//

import UIKit

class ViewDetail: UIViewController {

    @IBOutlet weak var viewDetail: UIView!
    
    @IBOutlet weak var descriptionDetail: UILabel!
    @IBOutlet weak var imageDetail: UIImageView!
    var textDescription = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.descriptionDetail.text = textDescription
        viewDetail.layer.cornerRadius = 10
        viewDetail.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }

    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
