//
//  PopupViewController.swift
//  Vesta
//
//  Created by MAD2 on 24/1/22.
//

import Foundation
import UIKit
import FirebaseStorage
class PopupViewController: UIViewController{
    
    @IBOutlet weak var proof: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let urlString = UserDefaults.standard.value(forKey:"url") as? String,
              let url = URL(string: urlString) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            DispatchQueue.main.async{
                let image = UIImage(data: data)
                self.proof.image = image
            }
        })
        task.resume()
        
    }
}
