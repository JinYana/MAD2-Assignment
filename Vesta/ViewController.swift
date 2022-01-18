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
var appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    var verification_id : String? = nil

    @IBOutlet weak var phoneNo: UITextField!
    
    @IBOutlet weak var enterOTP: UITextField!
    
    @IBAction func getOtp(_ sender: Any) {
        // get verification code from phone no
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNo.text!, uiDelegate: nil, completion: {verificationId,error in
            
            if(error != nil){
                
                print("Error in getting Verification ID")
            }else {
                self.verification_id = verificationId
                appDelegate.verId = verificationId
                print("Success in getting Verification ID")
                
                
            }
            
            
            
        })
        performSegue(withIdentifier: "getOTP", sender: self)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Hi
        var ref:DatabaseReference!
        
        ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
        
        var refHandle:DataSnapshot
        
        let data: Data // received from a network request, for example
        
        ref.child("Houses").observe(DataEventType.value, with:{ snapshot in
            
            let json = try? JSONSerialization.data(withJSONObject: snapshot.value)
            
            
            
        })
    }


}

