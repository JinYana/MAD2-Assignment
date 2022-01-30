//
//  AddGroceryVC.swift
//  Vesta
//
//  Created by herm on 19/1/22.
//

import Foundation
import FirebaseDatabase
import UIKit
import AVFoundation


class AddGroceryViewController:UIViewController,AVCaptureMetadataOutputObjectsDelegate{
    @IBOutlet weak var groceryname: UITextField!
    @IBOutlet weak var groceryquantity: UITextField!
    @IBOutlet weak var errormsg: UILabel!
    @IBOutlet weak var grocerydescription: UITextField!
    var ref:DatabaseReference!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    //create cam session
    let session = AVCaptureSession()
    
    override func viewDidLoad() {
        //code
        //Looks for single or multiple taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        
        tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
        appDelegate.productName = nil
        appDelegate.productCat = nil
        appDelegate.productImg = nil
        errormsg.isHidden = true
        
       
    }
    @IBAction func addmanualgrocery(_ sender: Any) {
        if groceryname.text == "" || grocerydescription.text == "" || groceryquantity.text == ""{
            errormsg.isHidden = false
        }
        else{
        
            ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
            //Adding the user to the exisiting house to the database
            guard let key = ref.child("Groceries").childByAutoId().key else { return }
            let post = ["name": groceryname.text!,
                        "description": grocerydescription.text!,
                        "quantity": groceryquantity.text,
                        "id": key,
                        "houseid": appDelegate.selectedHouse?.id] as [String : Any]
            ref.child("Groceries").child(key).updateChildValues(post)
            let post2 = [key: true]
            ref.child("Houses").child(appDelegate.selectedHouse!.id).child("groceryList").updateChildValues(post2)
            let alert = UIAlertController(title: "Add Grocery", message: "Grocery '\(groceryname.text as! String)' has been added to your grocery list", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)
                    self.navigationController?.popToRootViewController(animated: true)
                } )
        
            }
    }
    
    
    var video =  AVCaptureVideoPreviewLayer()
    @IBAction func addGroceryButton(_ sender: Any) {
     
    
    captureSess()
    
        
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        
        
        if metadataObjects != nil && metadataObjects != nil{
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject{
                //print(appDelegate.productName)
                
                
                
                
                if (object.type == AVMetadataObject.ObjectType.ean13 || object.type == AVMetadataObject.ObjectType.upce){

                    getNonfoodreq(upc:object.stringValue!)
                    if(appDelegate.productName != nil){
                        performSegue(withIdentifier: "confirmAddGroc", sender: nil)
                        
                        
                        connection.isEnabled = false
                        
                    }
                    
                    
                    
                    
                    
                }
                
                
                
            }
            
            
            
        }
        
    }// end of output function
    
    func captureSess(){
        
       
        
        //Device for capture
        let captureDev = AVCaptureDevice.default(for: .video)
        
        do{
            
            let deviceInput =  try! AVCaptureDeviceInput(device: captureDev!)
            session.addInput(deviceInput)
            
            
        }
        
        catch{
            print("Session cannot receive Input")
            
        }
        
        let deviceOutput = AVCaptureMetadataOutput()
        session.addOutput(deviceOutput)
        
        
        deviceOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        deviceOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.ean13,AVMetadataObject.ObjectType.upce]
        video = AVCaptureVideoPreviewLayer(session: session)
        //fill video to screen
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        
        //start capture sess
        session.startRunning()
        
        
        
        
        
    }
    
    func getNonfoodreq(upc:String) -> String{
        
        var dispName:String = ""
        let urlString = "https://eandata.com/feed/?v=3&keycode=2E105A5961EC5F63&mode=json&find=\(upc)"
                        
                        let url = URL(string:urlString)
                guard url != nil else{
                    return("fuk ur mder")
                }
                        let session = URLSession.shared
                        let dataTask = session.dataTask(with: url!) { data, response, error in
                        
                            
                            if error == nil && data != nil{
                                
                                
                                //parse json
                                let decoder = JSONDecoder()
                                do{
                                    let response =  try decoder.decode(nonFoodResponse.self,from:data!)
                                    
                                    self.appDelegate.productName = response.product.attributes.product
                                    self.appDelegate.productCat = response.product.attributes.category_text
                                    dispName = response.product.attributes.product
                                    
                                    self.appDelegate.productImg = response.product.image
                                    if response.product.hasImage == "No"{
                                        
                                        self.appDelegate.productImg = nil
                                        
                                    }
                                    
                                }
                                catch{
                                    print(error)
                                }
                            }
                        }
                dataTask.resume()
                return dispName
               
       
        
        
    
        
        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
        
}


// Structs to decode json for non food products
struct nonFoodResponse:Codable{
    //let status:statusobj
    let product:productobj
    
    

    
    
}


struct productobj:Codable{
    let attributes:attr
    let image:String
    let hasImage:String
    

    
}


struct attr:Codable{
    
    let product:String
    let category_text:String
    
}


        

    

        
        
        
        
        
       
        
        
    
    
    
    
    
    
    

