//
//  LandingPageViewController.swift
//  Vesta
//
//  Created by MAD2 on 24/1/22.
//

import Foundation
import UIKit
import Firebase


class LandingPageViewController : UIViewController, NotiDelegate{
    func popupokay() {
        ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
        //getting the users assigned chores from the database
        
        ref.child("Houses").observeSingleEvent(of: DataEventType.value, with:{ snapshot in
            
            if snapshot.childSnapshot(forPath: self.appDelegate.selectedHouse!.id).childSnapshot(forPath: "Completed").exists() && self.appDelegate.selectedUser?.role == "owner"{
                
                self.performSegue(withIdentifier: "noti", sender: self)
                
            }
            
            
        })
    }
    
    
    
    var ref: DatabaseReference!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting up selected user in app delegate
        ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
        
        ref.observe(DataEventType.value, with:{ snapshot in
            
            let role = snapshot.childSnapshot(forPath: "Houses").childSnapshot(forPath: self.appDelegate.selectedHouse!.id).childSnapshot(forPath: "userList").childSnapshot(forPath: self.appDelegate.selectedNum).value as! String
            
            
            let username = snapshot.childSnapshot(forPath: "Users").childSnapshot(forPath: self.appDelegate.selectedNum).childSnapshot(forPath: "name").value
            
            let user:User = User(name: username as! String, mobilenumber: self.appDelegate.selectedNum, role: role)
            
        
            
            self.appDelegate.selectedUser = user
        })
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
        //getting the users assigned chores from the database
        
        ref.child("Houses").observeSingleEvent(of: DataEventType.value, with:{ snapshot in
            
            if snapshot.childSnapshot(forPath: self.appDelegate.selectedHouse!.id).childSnapshot(forPath: "Completed").exists() && self.appDelegate.selectedUser?.role == "owner"{
                
                self.performSegue(withIdentifier: "noti", sender: self)
                
            }
            
            
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pop = segue.destination as? PopupViewController{
            pop.notiDelegate = self
        }
    }
    
    
    
}
