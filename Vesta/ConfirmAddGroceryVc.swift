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
    
   
    
    @IBOutlet weak var groceryImg: UIImageView!
    
    
    
    @IBAction func addButton(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cfmAddName.text = appDelegate.productName
        
        cfmAddDesc.text = appDelegate.productCat
        
    }
    
        
    
    
  
    
    
    
    
    
    
    
    
    
}
