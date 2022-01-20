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
        for metaData in metadataObjects
                {
                    let decodedData:AVMetadataMachineReadableCodeObject = metaData as! AVMetadataMachineReadableCodeObject
                    print(decodedData.stringValue)
                    print(decodedData.type)
                }
        
       }
}
        
        
        
        
        
       
        
        
    
    
    
    
    
    
    

