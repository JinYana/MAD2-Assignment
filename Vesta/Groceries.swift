//
//  Groceries.swift
//  Vesta
//
//  Created by herm on 24/1/22.
//

import Foundation

class Groceries{
    let name:String
    let notes: String?
    let nutritionInfo:String?
    let quantity:String?
    
    
    
    init(name:String,notes:String,nutritionInfo:String,quantity:String){
        self.name = name
        self.notes = notes
        self.nutritionInfo = nutritionInfo
        self.quantity = quantity
        
        
    }
}

