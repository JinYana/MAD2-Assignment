//
//  Chores.swift
//  Vesta
//
//  Created by MAD2 on 17/1/22.
//

import Foundation

class Chores {
    let name:String
    let user:String
    let date:Date
    let id
    
    
    init(name:String, id:String, mobilenumber:String){
        self.name = name
        self.id = id
        self.mobilenumber = mobilenumber
    }
}
