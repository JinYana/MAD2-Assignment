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
        
        ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
        //getting the users assigned chores from the database
        ref.child("Chores").observe(DataEventType.value, with:{ [self] snapshot in
            
            choreList.removeAll()
            
            
            for i in snapshot.children{
                
                let databasechores = snapshot.childSnapshot(forPath: (i as AnyObject).key)
                let assigneduser = databasechores.childSnapshot(forPath: "user").value
                       
                
                if assigneduser as! String == self.appDelegate.selectedNum{
                    
                    let chore = Chores(name: databasechores.childSnapshot(forPath: "name").value as! String, id: databasechores.childSnapshot(forPath: "id").value as! String, remarks: databasechores.childSnapshot(forPath: "remarks").value as! String, user: databasechores.childSnapshot(forPath: "user").value as! String, houseid: databasechores.childSnapshot(forPath: "houseid").value as! String)
                    if chore.houseid == self.appDelegate.selectedHouse!.id{
                        choreList.append(chore)
                    }
                    
                    
                }
            }
            
            
            self.tableView.reloadData()
        })
        
        
        
        
        
        
        
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
        
        appDelegate.selectedChores = choreList[indexPath.row]

    }
}


