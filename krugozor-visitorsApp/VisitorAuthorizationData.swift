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
    var birthdate: String?
    var phoneNumber: String!
    var password: String!
    var avatar: Data?

    init(fname: String!, lname: String?, patronymic: String?, email: String!, gender: String?, birthdate: String?, phoneNumber: String!, avatar: Data?) {
        
        self.fname = fname
        self.lname = lname
        self.patronymic = patronymic
        self.email = email
        self.gender = gender
        self.birthdate = birthdate
        self.phoneNumber = phoneNumber
    }
    
    init(fname: String!, lname: String?, email: String!, birthdate: String?, phoneNumber: String!, avatar: Data?) {
        
        self.fname = fname
        self.lname = lname
        self.email = email
        self.birthdate = birthdate
        self.phoneNumber = phoneNumber
    }
    
    init(email: String, password: String?) {
        
        self.email = email
        self.password = password
    }
    
    func arrayOfSelfParams () -> [(key: String, value: String?)] {
        
        var finalArray = [(key: String, value: String?)]()
        
        finalArray.append((key: "fname", value: self.fname))
        finalArray.append((key: "lname", value: self.lname))
        finalArray.append((key: "patronymic", value: self.patronymic))
        finalArray.append((key: "email", value: self.email))
        finalArray.append((key: "gender", value: self.gender))
        finalArray.append((key: "birthdate", value: self.birthdate))
        finalArray.append((key: "phoneNumber", value: self.phoneNumber))
        finalArray.append((key: "password", value: self.password))

        return finalArray
    }
    
 
}
