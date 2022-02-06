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
    @IBOutlet weak var numofchores: UILabel!
    @IBOutlet weak var numofgroc: UILabel!
    var grocList:[Grocery] = []
    var choreList:[Chores] = []
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
        
        ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
            //getting the users assigned chores from the database
        ref.child("Groceries").observe(DataEventType.value, with:{ [self] snapshot in
                
            grocList.removeAll()
                
            for i in snapshot.children{
                
                let databasegroc = snapshot.childSnapshot(forPath: (i as AnyObject).key)
                let houseid = databasegroc.childSnapshot(forPath: "houseid").value
                       
                
                if houseid as! String == self.appDelegate.selectedHouse!.id{
                    
                    let grocery = Grocery(name: databasegroc.childSnapshot(forPath: "name").value as! String, descrption: databasegroc.childSnapshot(forPath: "description").value as! String, nutritionInfo: "", quantity: databasegroc.childSnapshot(forPath: "quantity").value as! String, id: databasegroc.childSnapshot(forPath: "id").value as! String)
                    
                    grocList.append(grocery)
                    
                    
                    
                    
                }
            }
            numofgroc.text = "\(String(grocList.count)) Total Groceries"
            
            
            
        })
        
        ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
            //getting the users assigned chores from the database
        ref.child("Chores").observe(DataEventType.value, with:{ [self] snapshot in
                
            choreList.removeAll()
                
            for i in snapshot.children{
                
                let databasechores = snapshot.childSnapshot(forPath: (i as AnyObject).key)
                let assigneduser = databasechores.childSnapshot(forPath: "user").value
                       
                
                if assigneduser as! String == self.appDelegate.selectedNum{
                    
                    let chore = Chores(name: databasechores.childSnapshot(forPath: "name").value as! String, id: databasechores.childSnapshot(forPath: "id").value as! String, remarks: databasechores.childSnapshot(forPath: "remarks").value as! String, user: databasechores.childSnapshot(forPath: "user").value as! String, houseid: databasechores.childSnapshot(forPath: "houseid").value as! String)
                    if chore.houseid == self.appDelegate.selectedHouse!.id{
                        choreList.append(chore)
                    }
                    
                    
                }
            }
            
            
            
            numofchores.text = "\(String(choreList.count)) Pending Chores"
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pop = segue.destination as? PopupViewController{
            pop.notiDelegate = self
        }
    }
    
    
    
}
