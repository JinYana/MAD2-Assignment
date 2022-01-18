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

    var ref :DatabaseReference!
    
    
     
    @IBOutlet weak var housename: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
    }

    
    
    @IBAction func makehouse(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if housename.text != ""{
            ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
            guard let key = ref.child("Houses").childByAutoId().key else { return }
            let post = ["name": housename.text,
                        "userList": [appDelegate.selectedUser?.mobilenumber: true]] as [String : Any]
            let childUpdates = ["/Houses/\(key)": post]
            ref.updateChildValues(childUpdates)
        }
    }
}

