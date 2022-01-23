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
    
    
    var ref:DatabaseReference!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBAction func toaddGrocPage(_ sender: Any) {
        performSegue(withIdentifier: "addGroc", sender: sender)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
        //getting the users assigned chores from the database
        
        ref.child("Houses").observe(DataEventType.value, with:{ [self] snapshot in
            
            if snapshot.childSnapshot(forPath: appDelegate.selectedHouse!.id).childSnapshot(forPath: "Completed").exists(){
                
                performSegue(withIdentifier: "popup", sender: self)
                
            }
        })
            
        
        
    }
    
    
}
