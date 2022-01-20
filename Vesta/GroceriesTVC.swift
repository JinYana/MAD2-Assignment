//
//  GroceriesTVC.swift
//  Vesta
//
//  Created by herm on 19/1/22.
//

import Foundation
import UIKit

class GroceriesTVC:UITableViewController{
    
    
    @IBAction func toaddGrocPage(_ sender: Any) {
        performSegue(withIdentifier: "addGroc", sender: sender)
    }
    
    
}
