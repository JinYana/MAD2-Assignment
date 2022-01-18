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
    
        
    @IBOutlet weak var warning: UILabel!
    
       
    @IBAction func testButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Home") as UIViewController
            vc.modalPresentationStyle = .fullScreen
        self.present(vc,animated: true,completion: nil)
        
    }
    
    @IBAction func logIn(_ sender: Any) {
        if appDelegate.verId != nil{
            let credential = PhoneAuthProvider.provider().credential(withVerificationID:appDelegate.verId!, verificationCode: enterOTP.text!)
            Auth.auth().signIn(with: credential, completion: {authData,error in
                if (error != nil){
                    print(error.debugDescription)
                    self.warning.isHidden = false
                    
                    
                }else{
                    self.warning.isHidden = true
                    print("Authentication Succeed")
                    let storyboard = UIStoryboard(name: "Home", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "Home") as UIViewController
                        vc.modalPresentationStyle = .fullScreen
                    self.present(vc,animated: true,completion: nil)
                    
                }
                
                
            })
        
        }else{
            print("ERROR IN GETTING VERIFICATION ID")
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        warning.isHidden = true
    
    }


}
