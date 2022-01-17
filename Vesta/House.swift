//
//  House.swift
//  Vesta
//
//  Created by MAD2 on 17/1/22.
//

import Foundation

class House {
    let name:String
    let id:String
    let choreList: [String]
    let userList: [String]
    
    init(name:String, id:String, choreList:[String], userList:[String]){
        self.name = name
        self.id = id
        self.choreList = choreList
        self.userList = userList
    }
}
