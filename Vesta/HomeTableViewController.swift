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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        
        
        
        do {
            let storedObjItem = UserDefaults.standard.object(forKey: "houses")
            houseList = try JSONDecoder().decode([House].self, from: storedObjItem as! Data)

        } catch let err {
            print(err)
        }
        print(houseList[0].id)
        
        
        
        //setting up selected user in app delegate
        ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
        
        ref.child("Users").observe(DataEventType.value, with:{ snapshot in
            
            let username = snapshot.childSnapshot(forPath: self.appDelegate.selectedNum).childSnapshot(forPath: "name").value
            
            self.appDelegate.selectedUser = User(name: username as! String, mobilenumber: self.appDelegate.selectedNum)
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
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Home") as UIViewController
            vc.modalPresentationStyle = .fullScreen
        self.present(vc,animated: true,completion: nil)
        
        
        //getting the users assigned chores from the database
        ref.child("Chores").observe(DataEventType.value, with:{ [self] snapshot in
            let choreidlist:[String] = appDelegate.selectedHouse?.choreList as? [String] ?? []
            
            for i in choreidlist{
                
                let databasechores = snapshot.childSnapshot(forPath: i)
                let assigneduser = databasechores.childSnapshot(forPath: "user").value
                
                
                if assigneduser as! String == self.appDelegate.selectedUser!.mobilenumber{
                    
                    let chore = Chores(name: databasechores.childSnapshot(forPath: "name").value as! String, id: databasechores.childSnapshot(forPath: "id").value as! String, remarks: databasechores.childSnapshot(forPath: "remarks").value as! String, user: databasechores.childSnapshot(forPath: "user").value as! String)
                    choreList.append(chore)
                }
            }
            
            if let encoded = try? JSONEncoder().encode(self.choreList) {
                UserDefaults.standard.set(encoded, forKey: "chores")
                
            }
        })
        
        
        
        
        
        
    }


}
