//
//  ViewChoreController.swift
//  Vesta
//
//  Created by MAD2 on 22/1/22.
//

import Foundation
import UIKit
import Firebase

class ViewChoreTableViewController:UITableViewController{
    var ref:DatabaseReference!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var choreList:[Chores] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let storedObjItem = UserDefaults.standard.object(forKey: "chores")
            choreList = try JSONDecoder().decode([Chores].self, from: storedObjItem as! Data)

        } catch let err {
            print(err)
        }
        
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choreList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chore", for: indexPath)
        
        cell.textLabel!.text = choreList[indexPath.row].name
        cell.detailTextLabel!.text = choreList[indexPath.row].remarks
        
            
            
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}


