//
//  CatalogoView.swift
//  Proyecto2trimestre
//
//  Created by juandi on 13/02/2018.
//  Copyright © 2018 juandi. All rights reserved.
//

import UIKit

class CatalogoView: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate,UITextViewDelegate{
   
    
    var getFamily :String!
    
    
    @IBOutlet weak var collectionCatalogo: UICollectionView!
    
   
    var filteredProduct=[Product]()
    var listProduct = [Product]()
    let searchController = UISearchController(searchResultsController: nil)
    var textDetail:String = "hola mundo"
    var countProduct :UITextField?
    var id_product:Int = 0
    var price_product:Double = 0.0
    
    /*@IBAction func showDetail(_ sender: Any) {
        performSegue(withIdentifier: "detailsegue", sender: self)
    }*/
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        
        //creating collection view
        
        collectionCatalogo.dataSource=self
        collectionCatalogo.delegate=self
        
        let layout = self.collectionCatalogo.collectionViewLayout as! UICollectionViewFlowLayout
        collectionCatalogo.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        layout.sectionInset = UIEdgeInsets(top: -5,left: 5,bottom: -5,right: 5)
        
        layout.minimumInteritemSpacing = 2
        layout.itemSize = CGSize (width: (self.collectionCatalogo.frame.size.width )/2, height: self.collectionCatalogo.frame.size.height/3)
        
        //creating search view
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Products"
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        /*self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for tools and resources"
        searchController.searchBar.sizeToFit()
        
        searchController.searchBar.becomeFirstResponder()
        
        self.navigationItem.titleView = searchController.searchBar*/
        
        //setup the scope bar
        searchController.searchBar.scopeButtonTitles = ["All","Panes","Bizcochos y Tartas","Galletas","Bollería"]
        searchController.searchBar.delegate = self
        listProduct=Cache.getProducts();
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    func isFilter()->Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
   

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFilter(){
            return filteredProduct.count
        }
        return  listProduct.count
    }
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailsegue"
        {
            let segue = segue.destination as! ViewDetail
            segue.textDescription = textDetail
        }
    }*/

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellCatalogo=collectionCatalogo.dequeueReusableCell(withReuseIdentifier: "cellCatalogo", for: indexPath)as! CatalogoCell
       
        let product:Product
        if isFilter(){
            product = filteredProduct[indexPath.row]
        }else{
            product = listProduct[indexPath.row]
        }
        cellCatalogo.ImageView.image = product.imageDetail
        cellCatalogo.LabelName.text = product.name_product
        cellCatalogo.LabelPrice.text = product.price.description+"€"
        cellCatalogo.drawShadow()
        
        return cellCatalogo
        
        //Borde
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product:Product
        if isFilter(){
            product = filteredProduct[indexPath.row]
        }else{
            product = listProduct[indexPath.row]
        }
        
        id_product = product.id
        price_product = product.price
        
        let alertController = UIAlertController(title: "Comprar "+product.name_product.description, message: product.description.description, preferredStyle: .alert)
        
        let rect        = CGRect()//CGRectMake(15, 50, 240, 150.0)
        let textView    = UITextView(frame: rect)
        
        textView.font               = UIFont(name: "Helvetica", size: 15)
        textView.textColor          = UIColor.lightGray
        textView.backgroundColor    = UIColor.white
        textView.layer.borderColor  = UIColor.lightGray.cgColor
        textView.layer.borderWidth  = 1.0
        textView.text               = product.description.debugDescription
        textView.delegate           = self
        alertController.addTextField(configurationHandler: countProduct)
        alertController.view.addSubview(textView)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okaction=UIAlertAction(title:"AÑADIR", style: .default, handler: {action in self.okHanler()})
        alertController.addAction(cancel)
        alertController.addAction(okaction)
        
        self.present(alertController, animated: true, completion: {})
        
  
    }
   
    
    func countProduct(text:UITextField!){
        countProduct = text
        countProduct?.placeholder = "0 - 10"
    }
    func okHanler(){
        if countProduct?.text != "" {
            let count:Int = Int((countProduct?.text!)!)!
            
            if count > 0 && count < 10{
                let ticket = TicketDetail(id: 0,idTicket: 1,price: price_product,idproduct:id_product ,quantify: count)
                print(price_product, " ", ticket.price)
                Cache.ticketDetail.append(ticket)
                let num_ticket:Int = Cache.ticketDetail.count
                
            
                for i in (self.tabBarController?.tabBar.items!)! {
                    if i.tag==1{
                        i.badgeValue = num_ticket.description
                    }
                }
            }
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        //Deseleccionar borde
        cell?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.layer.borderWidth = 0.5
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    //MARK: -Segues
    //MARK: -Private instance method
    func searchBarIsEmpty()->Bool {
        //returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    func filterContentForSearchText(_ searchText:String,scope: String = "All"){
        filteredProduct = listProduct.filter({( product : Product) -> Bool in
            
            let doesCategoryMatch = (scope == "All") || ((Cache.getNameFamilyByProduct(id:product.family)) == scope)
            print(Cache.getNameFamilyByProduct(id: product.family))
            if searchBarIsEmpty(){
                
                return doesCategoryMatch
            }else{
                return doesCategoryMatch && product.name_product.lowercased().contains(searchText.lowercased())
            }
        })
        collectionCatalogo.reloadData()
    }
    
    /*func filterContentForSearchText(_ searchText:String,scope: String = "All"){
        filteredProduct = listProduct.filter({( product : Product) -> Bool in
            
            /*let doesCategoryMatch = (scope == "All") || ((Cache.getNameFamilyByProduct(id:product.family)) == scope)
            print(Cache.getNameFamilyByProduct(id: product.family))*/
            if searchBarIsEmpty(){
                
                return doesCategoryMatch
            }else{
                return doesCategoryMatch && product.name_product.lowercased().contains(searchText.lowercased())
            }
        })
        collectionCatalogo.reloadData()
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CatalogoView:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope:scope)
        
    }
}
extension CatalogoView:UISearchBarDelegate{
    func searchBar(_ searchBar:UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int){
        if getFamily == "" {
            filterContentForSearchText(searchBar.text!,scope:searchBar.scopeButtonTitles![selectedScope])
        }else{
            filterContentForSearchText(searchBar.text!,scope:"Galletas")
        }
      
    }
}
