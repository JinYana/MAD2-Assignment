//
//  AddGroceryVC.swift
//  Vesta
//
//  Created by herm on 19/1/22.
//

import Foundation

import UIKit
import BarcodeScanner


class AddGroceryVC:UITableViewController{
    
    
    @IBAction func addGroceryButton(_ sender: Any) {
        
        
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        
        
        
        
        
        present(viewController, animated:true, completion: nil)
        
        
    
    }
    
    
    
    
    override func viewDidLoad() {
        
    }
}
