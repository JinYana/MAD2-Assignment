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
    var ref:DatabaseReference!
    var choreList:[Chores] = []
    var role: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
        
        ref.child("Houses").observe(DataEventType.value, with:{ snapshot in
            
            self.houseList.removeAll()
            
            
            
            
            for child in snapshot.children {
                //Iterating through all the houses in the database
                let childSnapshot = snapshot.childSnapshot(forPath: (child as AnyObject).key).childSnapshot(forPath: "userList")
                if childSnapshot.childSnapshot(forPath: self.appDelegate.selectedNum).exists() {


                    let dataChange = snapshot.childSnapshot(forPath: (child as AnyObject).key).value as? [String:AnyObject]
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    let userarray = dataChange!["userList"]?.allKeys as! [String]
                    var chorearray: [String] = []
                    if (dataChange!["choreList"]?.allKeys) != nil{
                        chorearray = dataChange!["choreList"]?.allKeys as! [String]
                    }
                    
            
                    let house:House = House(name: dataChange!["name"] as! String, id: dataChange!["id"] as! String, choreList: chorearray, userList: userarray)
                    
                    
                    
                    self.houseList.append(house)
                    
                    
                    
                    
                    
                    
                    

                    
                }
            }
            
            self.tableView.reloadData()


         })
        
        
        
        
        
        
        
        

        
        
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houseList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "houseCell", for: indexPath) as! HomeTableViewCell
        
        cell.label.text = houseList[indexPath.row].name
        
            
            
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        appDelegate.selectedHouse = houseList[indexPath.row]
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Home") as UIViewController
            vc.modalPresentationStyle = .fullScreen
        self.present(vc,animated: true,completion: nil)
        
        
        
        
        
        
        
        
        
    }


}
