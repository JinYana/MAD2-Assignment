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
    


    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var ref:DatabaseReference!
    
    
    @IBOutlet weak var enterOTP: UITextField!
    
        
    @IBOutlet weak var warning: UILabel!
    
       
    @IBAction func testButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Home") as UIViewController
            vc.modalPresentationStyle = .fullScreen
        self.present(vc,animated: true,completion: nil)
        
        ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
        
        ref.child("Houses").observe(DataEventType.value, with:{ snapshot in
            
            
            
            
            for child in snapshot.children {
                //Iterating through all the houses in the database
                let childSnapshot = snapshot.childSnapshot(forPath: (child as AnyObject).key).childSnapshot(forPath: "userList")
                if childSnapshot.childSnapshot(forPath: "12345678").exists() {


                    let dataChange = snapshot.childSnapshot(forPath: (child as AnyObject).key).value as? [String:AnyObject]
                    
                    print(dataChange)
                    
                    



                    let userarray = dataChange!["userList"]?.allKeys as! [String]
                    var chorearray: [String] = []
                    if (dataChange!["chores"]?.allKeys) != nil{
                        chorearray = dataChange!["chores"]?.allKeys as! [String]
                    }
                    
                        
                    
                    
                    
                    let house:House = House(name: dataChange!["name"] as! String, id: dataChange!["id"] as! String, choreList: chorearray, userList: userarray)
                    
                    
                    
                    self.houseList.append(house)
                    
                    
                    
                    
                    

                    
                }
            }
            print(self.houseList)
            
            if let encoded = try? JSONEncoder().encode(self.houseList) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }

            
            
            



         })
        
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
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)

        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
    
    }


}
