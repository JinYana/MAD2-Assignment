//
//  ViewController.swift
//  Vesta
//
//  Created by MAD2 on 13/1/22.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Hi
        var ref:DatabaseReference!
        
        ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
        
        var refHandle:DataSnapshot
        
        let data: Data // received from a network request, for example
        
        ref.child("Houses").observe(DataEventType.value, with:{ snapshot in
            
            let json = try? JSONSerialization.data(withJSONObject: snapshot.value)
            
            
            
        })
    }


}

