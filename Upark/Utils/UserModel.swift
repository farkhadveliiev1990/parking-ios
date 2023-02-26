//
//  UserModel.swift
//  Upark
//
//  Created by JinYZ on 11/12/19.
//  Copyright © 2019 IT. All rights reserved.
//

import UIKit

class UserModel {
    var id: String
    var name: String
    var email: String
    var phone: String
    
    init() {
        id = ""
        name = ""
        email = ""
        phone = ""
    }
    
    func toFirebaseData() -> [String: Any] {
        return [
            "id" : id,
            "name" : name,
            "email" : email,
            "phone" : phone
        ]
    }
    
    func fromFirebase(data: [String: Any]) {
        id = data["id"] as! String
        name = data["name"] as! String
        email = data["email"] as! String
        phone = data["phone"] as! String
    }
}
