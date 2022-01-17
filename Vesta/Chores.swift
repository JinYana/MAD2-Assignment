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
    let id: String
    
    
    init(name:String, id:String, date:Date, user:String){
        self.name = name
        self.id = id
        self.date = date
        self.user = user
    }
}
