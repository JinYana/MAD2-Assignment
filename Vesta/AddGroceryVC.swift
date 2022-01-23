//
//  AddGroceryVC.swift
//  Vesta
//
//  Created by herm on 19/1/22.
//

import Foundation

import UIKit
import AVFoundation


class AddGroceryVC:UIViewController,AVCaptureMetadataOutputObjectsDelegate{
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        //code
       
    }
    
    
    var video =  AVCaptureVideoPreviewLayer()
    @IBAction func addGroceryButton(_ sender: Any) {
     
    captureSess()
    
        
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        
        
        if metadataObjects != nil && metadataObjects != nil{
            if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject{
                //print(appDelegate.productName)
                
                
                
                
                if (object.type == AVMetadataObject.ObjectType.ean13 || object.type == AVMetadataObject.ObjectType.upce){
                    getNonfoodreq(upc: object.stringValue!)
                    print(appDelegate.productName)
                    
                    
                    
                    
                       
//
//                    let detectedAlert = UIAlertController(title: "Is this the item you want to add?", message:getNonfoodreq(upc: object.stringValue!), preferredStyle: .alert)
//
//
//
//                    detectedAlert.addAction(UIAlertAction(title: "Add", style:.default, handler: nil))
//                    detectedAlert.addAction(UIAlertAction(title: "Retake", style: .default, handler:{(alert:UIAlertAction!) in AddGroceryVC().loadView()}))
//
//
//                    present(detectedAlert,animated: true,completion: nil)
                   
                    
                    
                }
                
                
                
            }
            
            if(appDelegate.productName != nil){
                performSegue(withIdentifier: "confirmAddGroc", sender: nil)
                connection.isEnabled = false
                
            }
            
            
        }
        
    }// end of output function
    
    func captureSess(){
        
        //create session
        let session = AVCaptureSession()
        
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
                                    print(response.product.attributes.long_desc)
                                    self.appDelegate.productName = response.product.attributes.long_desc
                                    self.appDelegate.productCat = response.product.attributes.category_text
                                    dispName = response.product.attributes.long_desc
                                    print(response.product.image)
                                }
                                catch{
                                    print(error)
                                }
                            }
                        }
                dataTask.resume()
                return dispName
               
       
        
        
    
        
        
    }
    
    
        
}

struct nonFoodResponse:Codable{
    //let status:statusobj
    let product:productobj
    
    

    
    
}

//struct statusobj:Codable{
//    let version:String
//    let code:String
//    let message:String
//    let find:String
//    let time:Float
//    let pause_until:Float
//    //let search:String
//    //let run:String
//    //let runtime:String
//
//
//}
struct productobj:Codable{
    let attributes:attr
    let image:String
    
// let locked:String
//    let modified:String
//    let hasImage:String
    
}


struct attr:Codable{
    
    let long_desc:String
    let category_text:String
    
}


        

    

        
        
        
        
        
       
        
        
    
    
    
    
    
    
    

