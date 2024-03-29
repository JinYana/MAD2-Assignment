//
//  ViewController.swift
//  Vesta
//
//  Created by MAD2 on 13/1/22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
var appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    
    var verification_id : String? = nil
    
    var ref:DatabaseReference!
    

    @IBOutlet weak var phoneNo: UITextField!
    
    @IBOutlet weak var enterOTP: UITextField!
    
    @IBAction func getOtp(_ sender: Any) {
        
        // get verification code from phone no
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
        PhoneAuthProvider.provider().verifyPhoneNumber("+65\(phoneNo.text!)", uiDelegate: nil, completion: {verificationId,error in
            
            if(error != nil){
                
                print(error.debugDescription)
            }else {
                self.verification_id = verificationId
                appDelegate.verId = verificationId
                print("Success in getting Verification ID")
                print(verificationId)
                
            }
            
            
            
        })
        
        appDelegate.selectedNum = phoneNo.text
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
                                                
        
            //Looks for single or multiple taps.
             let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            
            tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap)
        
        if Auth.auth().currentUser != nil{
            print("Authentication Succeed")
            let storyboard = UIStoryboard(name: "HouseSelector", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HouseSelector") as UIViewController
                vc.modalPresentationStyle = .fullScreen
            self.present(vc,animated: true,completion: nil)
            
            //removing +65 from the user phone number
            appDelegate.selectedNum = String((Auth.auth().currentUser?.phoneNumber?.dropFirst(3))!) as String
        }
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard
                let destination = segue.destination as? LoginVC
                else {
                    return
            }
        destination.phoneNo = phoneNo.text!
        }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    


}

