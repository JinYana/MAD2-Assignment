//
//  LoginVC.swift
//  Vesta
//
//  Created by herm on 18/1/22.
//

import Foundation

import UIKit
import FirebaseAuth
import FirebaseCore



class LoginVC: UIViewController {

    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    @IBOutlet weak var enterOTP: UITextField!
    
        
      
       
            
    @IBAction func logIn(_ sender: Any) {
        if appDelegate.verId != nil{
            let credential = PhoneAuthProvider.provider().credential(withVerificationID:appDelegate.verId!, verificationCode: enterOTP.text!)
            Auth.auth().signIn(with: credential, completion: {authData,error in
                if (error != nil){
                    print(error.debugDescription)
                    
                    
                }else{
                    
                    print("Authentication Succeed")
                }
                
                
            })
        
        }else{
            print("ERROR IN GETTING VERIFICATION ID")
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
    
    }


}
