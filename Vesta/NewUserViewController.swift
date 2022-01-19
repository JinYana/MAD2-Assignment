//
//  NewUserViewController.swift
//  Vesta
//
//  Created by MAD2 on 19/1/22.
//

import Foundation
import UIKit
import Firebase
class NewUserController: UIViewController{
    
    @IBOutlet weak var setname: UITextField!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var ref:DatabaseReference!

    @IBAction func confirmname(_ sender: Any) {
        if setname.text != ""{
            ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
            //Adding the new house to the database
            guard let key = ref.child("Users").childByAutoId().key else { return }
            let post = ["name": setname.text!,
                        "mobilenumber": appDelegate.selectedNum]
            let childUpdates = ["/Users/\(appDelegate.selectedNum as! String)": post]
            ref.updateChildValues(childUpdates)
        }
    }
    
        
        
        
        
    
    
}
