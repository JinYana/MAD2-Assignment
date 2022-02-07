//
//  PopupViewController.swift
//  Vesta
//
//  Created by MAD2 on 24/1/22.
//

import Foundation
import UIKit
import FirebaseStorage
import Firebase
class PopupViewController: UIViewController{
    
    weak var notiDelegate: NotiDelegate?
    @IBOutlet weak var remarks: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var proof: UIImageView!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var ref: DatabaseReference!
    var key: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //retriveing the completed chore
        ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
        
        
        
        ref.child("Houses").child(appDelegate.selectedHouse!.id).child("Completed").observeSingleEvent(of: .childAdded, with: { snapshot in
            
            self.key = snapshot.key
            
            self.remarks.text = "Remarks: \(snapshot.childSnapshot(forPath: "remarks").value as! String)"
            self.name.text = "\(snapshot.childSnapshot(forPath: "user").value as! String) has completed the chore: \(snapshot.childSnapshot(forPath: "name").value as! String)"
            
            let storage = Storage.storage().reference()
            let starsRef = storage.child("chores/\(snapshot.key)")
            
            // Fetch the download URL
            starsRef.downloadURL { url, error in
              if let error = error {
                // Handle any errors
              } else {
                // Get the download URL
                  let task = URLSession.shared.dataTask(with: url!, completionHandler: {data, _, error in
                      guard let data = data, error == nil else{
                          return
                      }
                      
                      DispatchQueue.main.async{
                          let image = UIImage(data: data)
                          self.proof.image = image
                      }
                  })
                  task.resume()
              }
            }
            })

        
        
            
        
        

        
        
        
        
    }
    //use the okay button to dismiss the popup
    @IBAction func okay(_ sender: Any) {
        ref.child("Houses").child(appDelegate.selectedHouse!.id).child("Completed").child(self.key).removeValue()
        dismiss(animated: true, completion: nil)
        
        notiDelegate?.popupokay()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ref.child("Houses").child(appDelegate.selectedHouse!.id).child("Completed").child(self.key).removeValue()
    
        notiDelegate?.popupokay()
    }
}
