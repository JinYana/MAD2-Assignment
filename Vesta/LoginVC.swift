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
import Firebase


class LoginVC: UIViewController {
    var houseList:[House] = []
    
    var phoneNo = ""
    var ref:DatabaseReference!
    
    
    @IBOutlet weak var enterOTP: UITextField!
    
        
    @IBOutlet weak var warning: UILabel!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
       
    
    
    @IBAction func logIn(_ sender: Any) {
        if appDelegate.verId != nil{
            let credential = PhoneAuthProvider.provider().credential(withVerificationID:appDelegate.verId!, verificationCode: enterOTP.text!)
            Auth.auth().signIn(with: credential, completion: { [self]authData,error in
                if (error != nil){
                    print(error.debugDescription)
                    self.warning.isHidden = false
                    
                    
                }else{
                    self.warning.isHidden = true
                    print("Authentication Succeed")
                    ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
                    ref.child("Users").observe(DataEventType.value, with:{ snapshot in
                        if !snapshot.childSnapshot(forPath: appDelegate.selectedNum).exists(){
                            let storyboard = UIStoryboard(name: "NewUser", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "NewUser") as UIViewController
                                vc.modalPresentationStyle = .fullScreen
                            self.present(vc,animated: true,completion: nil)
                                               
                        }
                        else{
                            let storyboard = UIStoryboard(name: "HouseSelector", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "HouseSelector") as UIViewController
                                vc.modalPresentationStyle = .fullScreen
                            self.present(vc,animated: true,completion: nil)
                        }
                        
                    })
                    
                    
                    
                    
                    
                }
                
            })
                
                
            
        
        }else{
            print("ERROR IN GETTING VERIFICATION ID")
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
        warning.isHidden = true
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)

        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
    
    }


}
