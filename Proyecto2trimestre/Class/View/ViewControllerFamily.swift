//
//  ViewControllerMain.swift
//  Proyecto2trimestre
//
//  Created by juandi on 09/02/2018.
//  Copyright © 2018 juandi. All rights reserved.
//



import UIKit

class ViewControllerFamily: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
 
    @IBOutlet weak var collectionView: UICollectionView!
    
    let families:[Family]=Cache.getFamilies()
    
        
    let familyImage:  [UIImage]=[
    
    UIImage(named: "1")!,
    UIImage(named: "2")!,
    UIImage(named: "3")!,
    UIImage(named: "4")!,
    
    ]
    var family:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource=self
        collectionView.delegate=self
        
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //collectionView.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 25)
        //layout.sectionInset = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
        layout.minimumInteritemSpacing = 2
        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width )/1, height: self.collectionView.frame.size.height/5)

        // Do any additional setup after loading the view.
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return families.count
    }
    
    //funcion de rellenar las celdas
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! myCollectionCell
        cell.imageView.image = familyImage[indexPath.row]
        cell.labelView.text = families[indexPath.row].family.description
        cell.drawShadow()
       

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
         self.family = self.families[indexPath.row].family
        print("nombre familia :"+self.family.description)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destino = segue.destination as? CatalogoView {
            destino.getFamily = family
        }
    }
   
    
 
   


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
