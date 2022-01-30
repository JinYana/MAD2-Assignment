//
//  GroceriesTVC.swift
//  Vesta
//
//  Created by herm on 19/1/22.
//

import Foundation
import UIKit
import Firebase

class ViewGroceriesTableViewController:UITableViewController{
    var grocList:[Grocery] = []
    
    
    var ref:DatabaseReference!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBAction func toaddGrocPage(_ sender: Any) {
        performSegue(withIdentifier: "addGroc", sender: sender)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.productName = nil
        appDelegate.productCat = nil
        appDelegate.productImg = nil
        ref = Database.database(url: "https://mad2-vesta-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
            //getting the users assigned chores from the database
        ref.child("Groceries").observe(DataEventType.value, with:{ [self] snapshot in
                
            grocList.removeAll()
                
            for i in snapshot.children{
                
                let databasegroc = snapshot.childSnapshot(forPath: (i as AnyObject).key)
                let houseid = databasegroc.childSnapshot(forPath: "houseid").value
                       
                
                if houseid as! String == self.appDelegate.selectedHouse!.id{
                    
                    let grocery = Grocery(name: databasegroc.childSnapshot(forPath: "name").value as! String, descrption: databasegroc.childSnapshot(forPath: "description").value as! String, nutritionInfo: "", quantity: databasegroc.childSnapshot(forPath: "quantity").value as! String, id: databasegroc.childSnapshot(forPath: "id").value as! String)
                    
                        grocList.append(grocery)
                    
                    
                    
                }
            }
            
            
            self.tableView.reloadData()
        })
            
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return grocList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "grocery", for: indexPath)
        
        cell.textLabel!.text = grocList[indexPath.row].name
        cell.detailTextLabel!.text = "x\(grocList[indexPath.row].quantity as! String)"

        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        appDelegate.selectedGrocery = grocList[indexPath.row]

    }
    
    
 
    
   
    
}
