//
//  CreateChoreViewHolder.swift
//  Vesta
//
//  Created by MAD2 on 21/1/22.
//

import Foundation
import UIKit
import Firebase


class CreateChoreViewController: UIViewController{
    
    
    @IBOutlet weak var errormsg: UILabel!
    @IBOutlet weak var choreuser: UITextField!
    @IBOutlet weak var choreremarks: UITextField!
    @IBOutlet weak var chorename: UITextField!
    var pickerview = UIPickerView()
    var users:[User] = []
    var ref:DatabaseReference!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        errormsg.isHidden = true
        //Looks for single or multiple taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        
        tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
        
        pickerview.delegate = self
        pickerview.dataSource = self
        choreuser.inputView = pickerview
        
        ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
        
        //getting list of users to assign chore to
        ref.observe(DataEventType.value, with:{ snapshot in
            
            
            
            let dataChange = snapshot.childSnapshot(forPath: "Houses").childSnapshot(forPath: self.appDelegate.selectedHouse!.id).value as? [String:AnyObject]
            print(dataChange)
            
            let userarray = dataChange!["userList"]?.allKeys as! [String]
            
            
            
            for i in userarray{
                let dataChange = snapshot.childSnapshot(forPath: "Users").childSnapshot(forPath: i).value as? [String:AnyObject]
                let role = snapshot.childSnapshot(forPath: "Houses").childSnapshot(forPath: self.appDelegate.selectedHouse!.id).childSnapshot(forPath: "userList").childSnapshot(forPath: i).value as! String
                let user = User(name: dataChange!["name"] as! String, mobilenumber: i, role: role)
                
                
                self.users.append(user)
                
                
                
            }
            

            self.ref.removeAllObservers()
        })
        
        
        
    }
    @IBAction func createchore(_ sender: Any) {
        if chorename.text == "" || choreuser.text == "" || choreremarks.text == ""{
            errormsg.isHidden = false
        }
        else{
            var selecteduser: String =  ""
            for i in users{
                if i.name == choreuser.text{
                    selecteduser = i.mobilenumber
                }
            }
            ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
            //Adding the user to the exisiting house to the database
            guard let key = ref.child("Chores").childByAutoId().key else { return }
            let post = ["name": chorename.text!,
                        "remarks": choreremarks.text!,
                        "user": selecteduser,
                        "id": key,
                        "houseid": appDelegate.selectedHouse?.id] as [String : Any]
            ref.child("Chores").child(key).updateChildValues(post)
            let post2 = [key: true]
            ref.child("Houses").child(appDelegate.selectedHouse!.id).child("choreList").updateChildValues(post2)
            
            appDelegate.selectedHouse?.choreList.append(key)
            let alert = UIAlertController(title: "Create Chore", message: "Chore has been created and sent to \(choreuser.text as! String)", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)
                    self.navigationController?.popToRootViewController(animated: true)
                } )
            
        }
        
    }
}

extension CreateChoreViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return users.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return users[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choreuser.text = users[row].name
        choreuser.resignFirstResponder()
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}
