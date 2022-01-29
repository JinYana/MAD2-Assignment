//
//  ProfileViewController.swift
//  Vesta
//
//  Created by MAD2 on 29/1/22.
//

import Foundation
import UIKit
import FirebaseAuth


class ProfileViewController: UIViewController{
    
    @IBOutlet weak var housecode: UILabel!
    @IBOutlet weak var currenthouse: UILabel!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var role: UILabel!
    @IBOutlet weak var phoneno: UILabel!
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        role.text = appDelegate.selectedUser?.role
        
        phoneno.text = appDelegate.selectedUser?.mobilenumber
        
        name.text = appDelegate.selectedUser?.name
        
        currenthouse.text = appDelegate.selectedHouse?.name
        
        housecode.text = appDelegate.selectedHouse?.id
        
    }
    @IBAction func logout(_ sender: Any) {
       try! Auth.auth().signOut()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Main") as UIViewController
            vc.modalPresentationStyle = .fullScreen
        self.present(vc,animated: true,completion: nil)
        
        
    }
}
