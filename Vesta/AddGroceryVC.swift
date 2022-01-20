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
    
    override func viewDidLoad() {
        //code
    }
    
    var video =  AVCaptureVideoPreviewLayer()
    @IBAction func addGroceryButton(_ sender: Any) {
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
        
    
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects != nil && metadataObjects.count != nil{
            
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject{
                
                if (object.type == AVMetadataObject.ObjectType.ean13 || object.type==AVMetadataObject.ObjectType.upce) {
                    
                    let detectedAlert = UIAlertController(title: "Code", message:object.stringValue, preferredStyle: .alert)
                    detectedAlert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    detectedAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: {(alert:UIAlertAction!) in session.stopRunning()}))
                    
                }
            }
            
        }
       }
        
    }
    }
        
        
        
        
        
       
        
        
    
    
    
    
    
    
    

