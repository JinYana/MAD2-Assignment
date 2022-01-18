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
        ref = Database.database().reference()
        self.ref.child("users/\(user.uid)/username").setValue(username)
    }
}

