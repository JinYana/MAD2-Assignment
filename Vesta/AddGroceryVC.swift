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
    //create cam session
    let session = AVCaptureSession()
    
    override func viewDidLoad() {
        //code
        appDelegate.productName = nil
        appDelegate.productCat = nil
        appDelegate.productImg = nil
        
       
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


        

    

        
        
        
        
        
       
        
        
    
    
    
    
    
    
    

