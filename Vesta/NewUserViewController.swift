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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        // allow user tap on screen to hide keyboard
        view.addGestureRecognizer(tapGesture)
    }

    @IBAction func confirmname(_ sender: Any) {
        if setname.text != ""{
            ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
            //Adding the new house to the database
            guard let key = ref.child("Users").childByAutoId().key else { return }
            let post = ["name": setname.text!,
                        "mobilenumber": appDelegate.selectedNum]
            let childUpdates = ["/Users/\(appDelegate.selectedNum as! String)": post]
            ref.updateChildValues(childUpdates)
            
            let storyboard = UIStoryboard(name: "HouseSelector", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HouseSelector") as UIViewController
                vc.modalPresentationStyle = .fullScreen
            self.present(vc,animated: true,completion: nil)
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
        
        
        
        
    
    
}
