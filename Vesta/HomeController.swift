//
//  HomeController.swift
//  Vesta
//
//  Created by MAD2 on 18/1/22.
//

import Foundation
import UIKit
import Firebase

class HomeController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var ref:DatabaseReference!
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
        
        ref.child("Houses").observe(DataEventType.value, with:{ snapshot in
            
            
            for child in snapshot.children {
                //Iterating through all the houses in the database
                let childSnapshot = snapshot.childSnapshot(forPath: (child as AnyObject).key).childSnapshot(forPath: "userList")
                if childSnapshot.childSnapshot(forPath: "12345678").exists() {
                    
                    
                    let dataChange = snapshot.childSnapshot(forPath: (child as AnyObject).key).value as? [String:AnyObject]
                    
                    
                    
                    let userarray = dataChange!["userList"]?.allKeys as! [String]
                    let chorearray = dataChange!["chores"]?.allKeys as! [String]
                    appDelegate.selectedHouse = House(name: dataChange!["name"] as! String, id: dataChange!["id"] as! String, choreList: chorearray, userList: userarray)
                    
                    print(appDelegate.selectedHouse!.userList)
                    break
                }
            }
            
            
            
        })
        
        
        ref.child("Users").child("12345678").observe(DataEventType.value, with:{ snapshot in
            
            
        })
        
        
        
        
    }


}

