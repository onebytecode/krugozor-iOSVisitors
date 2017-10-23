//
//  UserDataStruct.swift
//  anticafe-UserApp
//
//  Created by Анатолий on 25.09.17.
//  Copyright © 2017 OneByteCode. All rights reserved.
//

import Foundation

struct VisitorRegistrationData {
    
    var fname: String!
    var lname: String?
    var patronymic: String?
    var email: String!
    var gender: String?
    var birthDate: String?
    var phoneNumber: String!

// FIXME: Implement Visitor Avatar Handling
//    /// URL of smallest avatar image
//    var photoURLBanner: String?
//    /// Image of smallest avatar
//    var photoImageBanner: Data?
//    /// URL of largest avatar image
//    var photoURLOrigin: String?
//    /// Image of largest avatar
//    var photoImageOrigin: Data?

    init (fname: String!, lname: String?, patronymic: String?, email: String!, gender: String?, birthDate: String?, phoneNumber: String! ) {
        
        self.fname = fname
        self.lname = lname
        self.patronymic = patronymic
        self.email = email
        self.gender = gender
        self.birthDate = birthDate
        self.phoneNumber = phoneNumber
    }
}
