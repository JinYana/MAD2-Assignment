//
//  Chores.swift
//  Vesta
//
//  Created by MAD2 on 17/1/22.
//

import Foundation

class Chores : Codable{
    let name:String
    let user:String
    let remarks:String
    let id: String
    
    
    init(name:String, id:String, remarks:String, user:String){
        self.name = name
        self.id = id
        self.remarks = remarks
        self.user = user
    }
}
