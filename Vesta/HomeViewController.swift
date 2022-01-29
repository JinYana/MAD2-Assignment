//
//  HomeController.swift
//  Vesta
//
//  Created by MAD2 on 18/1/22.
//

import Foundation
import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var joinhouseerrormsg: UILabel!
    @IBOutlet weak var makehouseerrormsg: UILabel!
    var ref :DatabaseReference!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    @IBOutlet weak var houseid: UITextField!
    
    
    @IBOutlet weak var housename: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        makehouseerrormsg.isHidden = true
        joinhouseerrormsg.isHidden = true
        
        
        
        
        
    }
    @IBAction func joinhouse(_ sender: Any) {
        
        if houseid.text != ""{
            ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
            //Adding the user to the exisiting house to the database
            guard let key = ref.child("Houses").childByAutoId().key else { return }
            let post = [appDelegate.selectedNum!: "member"]
            ref.child("Houses").child(houseid.text!).observe(DataEventType.value, with:{ snapshot in
                if snapshot.exists(){
                    self.ref.child("Houses").child(self.houseid.text!).child("userList").updateChildValues(post)
                    self.navigationController?.popToRootViewController(animated: true)
                }
                else{
                    self.joinhouseerrormsg.isHidden = false
                }
                
            })
            
        }
        else{
            self.joinhouseerrormsg.isHidden = false
        }
    }
    
    
    
    
    @IBAction func makehouse(_ sender: Any) {
        if housename.text != ""{
            ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
            //Adding the new house to the database
            guard let key = ref.child("Houses").childByAutoId().key else { return }
            let post = ["name": housename.text!,
                        "id": key]
            let childUpdates = ["/Houses/\(key)": post]
            ref.updateChildValues(childUpdates)
            
            //Adding user to newly created house
            let post2 = [appDelegate.selectedUser?.mobilenumber: "owner"]
            let childUpdates2 = ["/Houses/\(key)/userList": post2]
            ref.updateChildValues(childUpdates2)
            self.navigationController?.popToRootViewController(animated: true)
            
            
        }
        else{
            makehouseerrormsg.isHidden = false
        }
    }
}

