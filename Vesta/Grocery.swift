//
//  Groceries.swift
//  Vesta
//
//  Created by herm on 24/1/22.
//

import Foundation

class Grocery{
    let name:String
    let description: String
    let nutritionInfo:String
    let quantity:String
    let id:String
    
    
    
    init(name:String,descrption:String,nutritionInfo:String,quantity:String,id:String){
        self.name = name
        self.description = descrption
        self.nutritionInfo = nutritionInfo
        self.quantity = quantity
        self.id = id
        
        
    }
}

