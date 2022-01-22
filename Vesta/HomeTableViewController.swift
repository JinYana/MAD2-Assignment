//
//  HomeTableViewController.swift
//  Vesta
//
//  Created by MAD2 on 18/1/22.
//

import Foundation
import Firebase
import UIKit


class HomeTableViewController: UITableViewController {
    var houseList:[House] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        
        
        
        do {
            let storedObjItem = UserDefaults.standard.object(forKey: "items")
            houseList = try JSONDecoder().decode([House].self, from: storedObjItem as! Data)
            
        } catch let err {
            print(err)
        }
        print(houseList[0].id)
        
        
        
        
//        ref.child("Users").child("12345678").observe(DataEventType.value, with:{ snapshot in
//            appDelegate.selectedUser = User(name: snapshot.childSnapshot(forPath: "name").value as! String, mobilenumber: snapshot.childSnapshot(forPath: "mobilenumber").value as! String)
//
//        })
        
        
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houseList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "houseCell", for: indexPath)
        
        cell.textLabel!.text = houseList[indexPath.row].name
        
            
            
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        appDelegate.selectedHouse = houseList[indexPath.row]
        print(appDelegate.selectedHouse?.name)
        print(houseList[indexPath.row])
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Home") as UIViewController
            vc.modalPresentationStyle = .fullScreen
        self.present(vc,animated: true,completion: nil)
    }


}
