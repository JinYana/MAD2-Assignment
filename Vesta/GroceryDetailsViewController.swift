//
//  GroceryDetailsViewController.swift
//  Vesta
//
//  Created by MAD2 on 30/1/22.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase

class GroceryDetailsViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var quantity: UITextField!
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var grocerydesc: UILabel!
    @IBOutlet weak var groceryname: UILabel!
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        let selectedgroc = appDelegate.selectedGrocery
        quantity.text = selectedgroc?.quantity
        groceryname.text = selectedgroc?.name
        grocerydesc.text = selectedgroc?.description
        
        
        let storage = Storage.storage().reference()
        let starsRef = storage.child("groceries/\(appDelegate.selectedGrocery?.id as! String)")
        
       
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
                      self.picture.image = image
                  }
              })
              task.resume()
          }
        
        }
        
    }
    
    
    
    
    //minus quantity of food
    @IBAction func minus(_ sender: Any) {
        if Int(quantity.text!)! >= 0{
            quantity.text = String(Int(quantity.text!)! - 1)
        }
        
        
        if Int(quantity.text!)! > 0{
            //Adding the user to the exisiting house to the database
            ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
            guard let key = ref.child("Houses").childByAutoId().key else { return }
            let post = ["quantity": quantity.text ]
            
            self.ref.child("Groceries").child(appDelegate.selectedGrocery!.id).updateChildValues(post)
            
        }
        else{
            self.ref.child("Groceries").child(appDelegate.selectedGrocery!.id).removeValue()
        }
        
    }
    
    //add quantity of food
    @IBAction func add(_ sender: Any) {
        quantity.text = String(Int(quantity.text!)! + 1)
        
        
        if Int(quantity.text!)! > 0{
            //Adding the user to the exisiting house to the database
            ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
            guard let key = ref.child("Houses").childByAutoId().key else { return }
            let post = ["quantity": quantity.text ]
            
            self.ref.child("Groceries").child(appDelegate.selectedGrocery!.id).updateChildValues(post)
            
        }
        else{
            self.ref.child("Groceries").child(appDelegate.selectedGrocery!.id).removeValue()
            
        }
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

        picture.image = image
        let storage = Storage.storage().reference()
                
                
       storage.child("groceries/\(appDelegate.selectedGrocery?.id as! String)").putData(picture.image!.pngData()! , metadata: nil, completion: { _, error in guard error == nil else{
            print("Failed to upload")
            return
           
            }
       })
        
        

    }
    
    
    @IBAction func changedquantity(_ sender: Any) {
        
        if Int(quantity.text!)! > 0{
            //Adding the user to the exisiting house to the database
            ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
            guard let key = ref.child("Houses").childByAutoId().key else { return }
            let post = ["quantity": quantity.text ]
            
            self.ref.child("Groceries").child(appDelegate.selectedGrocery!.id).updateChildValues(post)
            
        }
        else{
            self.ref.child("Groceries").child(appDelegate.selectedGrocery!.id).removeValue()
        }
    }
    
    
    
    
    
    // set image and save image to firebase
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    

}
