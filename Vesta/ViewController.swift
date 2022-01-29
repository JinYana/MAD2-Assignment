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
        
        if Auth.auth().currentUser != nil{
            print("Authentication Succeed")
            let storyboard = UIStoryboard(name: "HouseSelector", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HouseSelector") as UIViewController
                vc.modalPresentationStyle = .fullScreen
            self.present(vc,animated: true,completion: nil)
            
            appDelegate.selectedNum = String((Auth.auth().currentUser?.phoneNumber?.dropFirst(3))!) as String
        }
        
        
        
        ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
        
        var refHandle:DataSnapshot
        
        let data: Data // received from a network request, for example
        
        ref.child("Houses").observe(DataEventType.value, with:{ snapshot in
            
            let json = try? JSONSerialization.data(withJSONObject: snapshot.value)
            
            
            
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard
                let destination = segue.destination as? LoginVC
                else {
                    return
            }
        destination.phoneNo = phoneNo.text!
        }
    
    


}

