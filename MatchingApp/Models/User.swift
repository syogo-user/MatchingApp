//
//  User.swift
//  MatchingApp
//
//  Created by 小野寺祥吾 on 2021/04/03.
//

import Foundation
import Firebase
class User{
    var email:String
    var name:String
    var createAt:Timestamp
    init(dic:[String:Any]) {
        self.email = dic["email"] as? String ?? ""
        self.name = dic["name"] as? String ?? ""
        self.createAt = dic["createdAt"] as? Timestamp ?? Timestamp()
    }
}
