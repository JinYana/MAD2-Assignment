//
//  ConfirmAddGroceryVc.swift
//  Vesta
//
//  Created by herm on 24/1/22.
//

import Foundation
import UIKit

class ConfirmAddGroceryVc:UIViewController{
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var cfmAddName: UILabel!
    
    @IBOutlet weak var cfmAddDesc: UILabel!
    
    @IBOutlet weak var noImgLbl: UILabel!
    
    
    @IBOutlet weak var groceryImg: UIImageView!
    
    
    
    @IBAction func addButton(_ sender: Any) {
        // add to firebase
        
        
        //segue back to tablevc
        
        
    }
    
    
    @IBAction func backToGrocPg(_ sender: Any) {
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        noImgLbl.isHidden = true
        self.navigationItem.hidesBackButton = true
        cfmAddName.text = appDelegate.productName
        
        cfmAddDesc.text = appDelegate.productCat
        
        
        if appDelegate.productImg == nil{
            noImgLbl.isHidden = false
            
            
        }
        
         let url = URL(string:appDelegate.productImg!)
        
        
        getData(from: url!) { data, response, error in
            guard let data = data,error == nil else{return}
            
            DispatchQueue.main.async() {
                [weak self] in self?.groceryImg.image = UIImage(data: data)
            }
        }
        
        
        
        
}
    
  
    
    func getData(from url:URL ,completion:@escaping (Data?,URLResponse?,Error?) ->()){
        
        
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
  
    
    
    
    
    
    
    
    
    
}
