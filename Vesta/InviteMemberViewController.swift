//
//  InviteMemberViewController.swift
//  Vesta
//
//  Created by MAD2 on 6/2/22.
//

import Foundation
import UIKit
class InviteMemberViewController: UIViewController{
    
    @IBOutlet weak var invalidphonenum: UILabel!
    @IBOutlet weak var not8char: UILabel!
    @IBOutlet weak var nophonenum: UILabel!
    @IBOutlet weak var memberphone: UITextField!
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        // allow user tap on screen to hide keyboard
        view.addGestureRecognizer(tapGesture)
        not8char.isHidden = true
        nophonenum.isHidden = true
        invalidphonenum.isHidden = true
        
        
    }
    @IBAction func invitemember(_ sender: Any) {
        not8char.isHidden = true
        nophonenum.isHidden = true
        if memberphone.text == ""{
            nophonenum.isHidden = false
        }
        else if memberphone.text?.count != 8{
            not8char.isHidden = false
        }
        else{
            let semaphore = DispatchSemaphore (value: 0)

            let parameters = "From=%2B16204624618&To=%2B65\(memberphone.text as! String)&Body=Join \(appDelegate.selectedUser?.name as! String)'s house in Vesta using the house code: \(appDelegate.selectedHouse?.id as! String)"
            let postData =  parameters.data(using: .utf8)

            var request = URLRequest(url: URL(string: "https://api.twilio.com/2010-04-01/Accounts/AC7a9337b3395bfa73ec65dbdf3ff6991b/Messages")!,timeoutInterval: Double.infinity)
            request.addValue("Basic QUM3YTkzMzdiMzM5NWJmYTczZWM2NWRiZGYzZmY2OTkxYjo2ZjQ3YTRmNTRjMzRjOGI3MmY4YWYxNmFkMjVkNTNhNA==", forHTTPHeaderField: "Authorization")
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

            request.httpMethod = "POST"
            request.httpBody = postData

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
              guard let data = data else {
                print(String(describing: error))
                  
                semaphore.signal()
                return
              }
              print(String(data: data, encoding: .utf8)!)
              semaphore.signal()
              
            }

            task.resume()
            semaphore.wait()
            let alert = UIAlertController(title: "Invite Sent", message: "Your house code has been sent to  \(memberphone.text) via SMS", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)
                    self.dismiss(animated: true, completion: nil)
                } )
            
            
        }
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
