//
//  UserDataStruct.swift
//  anticafe-UserApp
//
//  Created by Анатолий on 25.09.17.
//  Copyright © 2017 OneByteCode. All rights reserved.
//

import Foundation

struct VisitorAuthorizationData {
    
    var fname: String!
    var lname: String?
    var patronymic: String?
    var email: String!
    var gender: String?
    var birthDate: String?
    var phoneNumber: String!
    var password: String!
    var avatar: Data?

    init(fname: String!, lname: String?, patronymic: String?, email: String!, gender: String?, birthDate: String?, phoneNumber: String!, avatar: Data?) {
        
        self.fname = fname
        self.lname = lname
        self.patronymic = patronymic
        self.email = email
        self.gender = gender
        self.birthDate = birthDate
        self.phoneNumber = phoneNumber
    }
    
    init(email: String, password: String) {
        
        self.email = email
        self.password = password
    }
}
