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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var ref:DatabaseReference!
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
        
        ref.child("Houses").observe(DataEventType.value, with:{ snapshot in
            
            
            
            
            for child in snapshot.children {
                //Iterating through all the houses in the database
                let childSnapshot = snapshot.childSnapshot(forPath: (child as AnyObject).key).childSnapshot(forPath: "userList")
                if childSnapshot.childSnapshot(forPath: "12345678").exists() {


                    let dataChange = snapshot.childSnapshot(forPath: (child as AnyObject).key).value as? [String:AnyObject]
                    
                    print(dataChange)
                    
                    



                    let userarray = dataChange!["userList"]?.allKeys as! [String]
                    var chorearray: [String] = []
                    if (dataChange!["chores"]?.allKeys) != nil{
                        chorearray = dataChange!["chores"]?.allKeys as! [String]
                    }
                    
                        
                    
                    
                    
                    let house:House = House(name: dataChange!["name"] as! String, id: dataChange!["id"] as! String, choreList: chorearray, userList: userarray)
                    
                    
                    
                    self.houseList.append(house)
                    
                    
                    
                    
                    

                    
                }
            }
            print(self.houseList)
            
            if let encoded = try? JSONEncoder().encode(self.houseList) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }

            
            
            



         })
        
        do {
            let storedObjItem = UserDefaults.standard.object(forKey: "items")
            houseList = try JSONDecoder().decode([House].self, from: storedObjItem as! Data)
            
        } catch let err {
            print(err)
        }
        
        
        
        
        ref.child("Users").child("12345678").observe(DataEventType.value, with:{ snapshot in
            appDelegate.selectedUser = User(name: snapshot.childSnapshot(forPath: "name").value as! String, mobilenumber: snapshot.childSnapshot(forPath: "mobilenumber").value as! String)
            
        })
        
        
        
        
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
        print(houseList[indexPath.row])
    }


}
