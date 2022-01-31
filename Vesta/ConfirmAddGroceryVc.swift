//
//  ConfirmAddGroceryVc.swift
//  Vesta
//
//  Created by herm on 24/1/22.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage
var ref:DatabaseReference!

class ConfirmAddGroceryVc:UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var cfmAddName: UILabel!
    
    @IBOutlet weak var errormsg: UILabel!
    @IBOutlet weak var cfmAddDesc: UILabel!
    
    @IBOutlet weak var noImgLbl: UILabel!
    
    
    @IBOutlet weak var groceryImg: UIImageView!
    
    @IBOutlet weak var quantityField: UITextField!
    
    
    @IBAction func addButton(_ sender: Any) {
        if quantityField.text != ""{
            // add to firebase
            ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
            //Adding the user to the exisiting house to the database
            guard let key = ref.child("Groceries").childByAutoId().key else { return }
            let post = ["name": appDelegate.productName,
                        "description": appDelegate.productCat,
                        "quantity": quantityField.text!,
                        "id": key,
                        "houseid": appDelegate.selectedHouse?.id] as [String : Any]
            ref.child("Groceries").child(key).updateChildValues(post)
            
            // add user's image to firebase storage
            let storage = Storage.storage().reference()
            
            storage.child("groceries/\(key)").putData(groceryImg.image!.pngData()!,metadata: nil,completion:{_, error in guard error == nil else {
                
                print("Failed To Upload")
                return
                
            }
                
            })
            
            
           
            
            // add grocery to user's house
            let post2 = [key: true]
            ref.child("Houses").child(appDelegate.selectedHouse!.id).child("groceryList").updateChildValues(post2)
                let alert = UIAlertController(title: "Add Grocery", message: "Grocery '\(appDelegate.productName!)' has been added to your grocery list", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)
                    //return to root view controller
                    self.navigationController?.popToRootViewController(animated: true)
                    
                    
                } )
            
            
            
            
        }
        else{
            errormsg.isHidden = false
        }
        
    }
    
    // init camera
    @IBAction func captureItem(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
        
       
        
    }
    
    // set user's taken image as imageview
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }

        groceryImg.image = image
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errormsg.isHidden = true
        // allow user to tap on screen to hide keyboard
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        noImgLbl.isHidden = true
        self.navigationItem.hidesBackButton = true
        cfmAddName.text = appDelegate.productName
        
        cfmAddDesc.text = appDelegate.productCat
        
        
        if appDelegate.productImg == nil{
            noImgLbl.isHidden = false
            
            
        }
        // download defualt image from API
        let url = URL(string:appDelegate.productImg!)
        
        getData(from: url!) { data, response, error in
            guard let data = data,error == nil else{return}
            
            DispatchQueue.main.async() {
                [weak self] in self?.groceryImg.image = UIImage(data: data)
            }
        }
        
        
        
        
}
    
  
    
    func getData(from url:URL ,completion:@escaping (Data?,URLResponse?,Error?) ->()){
        
        
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    

    
    
}
