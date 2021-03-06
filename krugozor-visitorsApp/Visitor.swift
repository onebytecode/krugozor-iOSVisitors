//
//  Visitor.swift
//  krugozor-visitorsApp
//
//  Created by Alexander Danilin on 21/10/2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation
import RealmSwift

class Visitor: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var fname = ""
    @objc dynamic var lname = ""
    @objc dynamic var patronymic = ""
    @objc dynamic var gender = ""
    @objc dynamic var birthdate = ""
    @objc dynamic var email = ""
    @objc dynamic var phoneNumber = ""
    @objc dynamic var sessionToken = ""
    @objc dynamic var serverID = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func arrayOfSelfFields () -> [String] {
        let array = [ "id", "fname", "lname", "patronymic", "gender", "birthdate", "email", "phoneNumber", "sessionToken"]
        return array
    }
    
}
