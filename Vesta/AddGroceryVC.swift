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
    
    let session = AVCaptureSession()
    
    override func viewDidLoad() {
        //code
    }
    
    var video =  AVCaptureVideoPreviewLayer()
    @IBAction func addGroceryButton(_ sender: Any) {
        //create session
        
        
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
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        
        if metadataObjects != nil && metadataObjects != nil{
            if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject{
                
                
                if (object.type == AVMetadataObject.ObjectType.ean13 || object.type == AVMetadataObject.ObjectType.upce){
                    
                    let detectedAlert = UIAlertController(title: "Is this the item you want to add?", message:object.stringValue, preferredStyle: .alert)
                    
                    detectedAlert.addAction(UIAlertAction(title: "Add", style:.default, handler: nil))
                    detectedAlert.addAction(UIAlertAction(title: "Retake", style: .default, handler:{(alert:UIAlertAction!) in AddGroceryVC().loadView()}))
                    
                    
                    present(detectedAlert,animated: true,completion: nil)
                    
                }
                
                
                
            }
            
            
            
            
            
        }
        
        
    }// end of output function
    
    func getReq(){
        
        
        var semaphore = DispatchSemaphore (value: 0)

                var request = URLRequest(url: URL(string: "https://barcode-lookup.p.rapidapi.com/v3/products?barcode=7702018866984%22")!,timeoutInterval: Double.infinity)
                request.addValue("barcode-lookup.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
                request.addValue("8d644bd287msh96f7c05ac86b553p136a3cjsn66e1ddc83716", forHTTPHeaderField: "x-rapidapi-key")
                request.addValue("__cflb=0H28uyvJ4CKpQyt4K4sAVoNGmQD7bdrdBPWE62PRG7P", forHTTPHeaderField: "Cookie")

                request.httpMethod = "GET"

                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                  guard let data = data else {
                    print(String(describing: error))
                    semaphore.signal()
                    return
                  }
                  print(String(data: data, encoding: .utf8)!)

                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                        print(json)
                    }catch{ print("erroMsg") }



                  semaphore.signal()
                }

                task.resume()
                semaphore.wait()
        
        
        
        
        
        
        
        
    }
    
    
        
}
        

    

        
        
        
        
        
       
        
        
    
    
    
    
    
    
    

