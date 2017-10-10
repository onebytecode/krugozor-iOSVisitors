//
//  UserDataStruct.swift
//  anticafe-UserApp
//
//  Created by Анатолий on 25.09.17.
//  Copyright © 2017 OneByteCode. All rights reserved.
//

import Foundation

struct UserDataStruct {
    var name: String?
    var surname: String?
    var email: String?
    var gender: Bool?
    /// Is this user last used the session
    var session: Bool?
    var age: Int?
    
    var phoneNumber: String?
    var birthDate: String?

    /// URL of smallest avatar image
    var photoURLBanner: String?
    /// Image of smallest avatar
    var photoImageBanner: Data?
    /// URL of largest avatar image
    var photoURLOrigin: String?
    /// Image of largest avatar
    var photoImageOrigin: Data?

    // Returns of state of object
    var isEmpty: Bool

    init (userData: UserData) {
        self.name = userData.name
        self.surname = userData.surname
        self.age = Int(userData.age)
        self.email = userData.email
        self.gender = userData.gender
        self.session = userData.session
        self.photoImageBanner = userData.photoImageBanner
        self.photoImageOrigin = userData.photoImageOrigin
        self.photoURLBanner = userData.photoURLBanner
        self.photoURLOrigin = userData.photoURLOrigin
        self.isEmpty = false
    }

    /// Init empty object of type UserDataStruct with mark "empty"
    init () {
        isEmpty = true
    }
}

///Search for user data by one of the object fields of UserDataStruct
enum UserRequestType: String {
    case name
    case surname
    case email
}
