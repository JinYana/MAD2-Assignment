//
//  Complete Chore.swift
//  Vesta
//
//  Created by MAD2 on 23/1/22.
//

import Foundation
import UIKit
import FirebaseStorage
import Firebase


class CompleteChoreViewController : UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    @IBOutlet weak var chorename: UILabel!
    @IBOutlet weak var remarks: UILabel!
    
    
    var ref:DatabaseReference!
    @IBOutlet weak var proof: UIImageView!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var complete: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chorename.text = "Chore Name: \(appDelegate.selectedChores?.name)"
        
        remarks.text = "Remarks: \(appDelegate.selectedChores?.remarks)"
        
        
    }
    
    @IBAction func takepic(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }

        proof.image = image
        
        
        

    }
    
    
    @IBAction func completeChore(_ sender: Any) {
        if proof.image != nil{
            // if users role is not an owner, send photo taken to firebase
            if appDelegate.selectedUser?.role != "owner"{
                let storage = Storage.storage().reference()
                
                
                storage.child("chores/\(appDelegate.selectedChores?.id as! String)").putData(proof.image!.pngData()! , metadata: nil, completion: { _, error in guard error == nil else{
                    print("Failed to upload")
                    return
                   }
                })
                
                
                
                ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
                
                
                let post = ["name": appDelegate.selectedChores?.name,
                            "remarks": appDelegate.selectedChores?.remarks,
                            "user": appDelegate.selectedUser?.name]
                
                ref.child("Houses").child(appDelegate.selectedHouse!.id).child("Completed").child(appDelegate.selectedChores!.id).updateChildValues(post)
                
                ref.child("Houses").child(appDelegate.selectedHouse!.id).child("choreList").child(appDelegate.selectedChores!.id).removeValue()
                
                ref.child("Chores").child(appDelegate.selectedChores!.id).removeValue()
                
                
                
        //        let semaphore = DispatchSemaphore (value: 0)
        //
        //        let parameters = "From=%2B16204624618&To=%2B6587817479&Body=\(appDelegate.selectedUser?.name as! String) has completed the chore '\(appDelegate.selectedChores?.name as! String)'. Log onto vesta to check on him!"
        //        let postData =  parameters.data(using: .utf8)
        //
        //        var request = URLRequest(url: URL(string: "https://api.twilio.com/2010-04-01/Accounts/AC7a9337b3395bfa73ec65dbdf3ff6991b/Messages")!,timeoutInterval: Double.infinity)
        //        request.addValue("Basic QUM3YTkzMzdiMzM5NWJmYTczZWM2NWRiZGYzZmY2OTkxYjo2ZjQ3YTRmNTRjMzRjOGI3MmY4YWYxNmFkMjVkNTNhNA==", forHTTPHeaderField: "Authorization")
        //        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        //
        //        request.httpMethod = "POST"
        //        request.httpBody = postData
        //
        //        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        //          guard let data = data else {
        //            print(String(describing: error))
        //            semaphore.signal()
        //            return
        //          }
        //          print(String(data: data, encoding: .utf8)!)
        //          semaphore.signal()
        //        }
        //
        //        task.resume()
        //        semaphore.wait()
                dismiss(animated: true, completion: nil)
            }
            else{
                //else just remove chore from database
                ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
                
                ref.child("Houses").child(appDelegate.selectedHouse!.id).child("choreList").child(appDelegate.selectedChores!.id).removeValue()
                
                ref.child("Chores").child(appDelegate.selectedChores!.id).removeValue()
                dismiss(animated: true, completion: nil)
            }
        }
        
        
        
        
        
    }
}
