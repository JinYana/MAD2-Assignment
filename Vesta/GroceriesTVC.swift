//
//  GroceriesTVC.swift
//  Vesta
//
//  Created by herm on 19/1/22.
//

import Foundation
import UIKit
import Firebase

class GroceriesTVC:UITableViewController{
    var grocList:[Groceries] = []
    
    
    var ref:DatabaseReference!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBAction func toaddGrocPage(_ sender: Any) {
        performSegue(withIdentifier: "addGroc", sender: sender)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            
        
        
    }
    
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
////    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////
////
////
////    }
//    
    
   
    
}
