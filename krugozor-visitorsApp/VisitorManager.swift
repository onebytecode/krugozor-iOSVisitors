//
//  VisitorManager.swift
//  krugozor-visitorsApp
//
//  Created by Alexander Danilin on 21/10/2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation

protocol VisitorManaging {
    
    // 1. get the last visitor's email
    func getLastVisitorEmail() -> String?
    // 2. check if current visitor has registered account on server -> get JSON response with all Visitor's Model fields
    func isRegisteredVisitor(_ email: String) -> [Any]?
    // 3. send visitor's email & password -> get hash response
    func getHashValueForVisitor(_ email: String, password: String) -> String
    // 4. register new visitor's with name, last name (optional), phone number & date of birth -> get response (like a boolean true/false)
    func registerNewVisitor(_ fname: String, lname: String?, phone: String, dateOfBirth: String) -> Bool
    // 5. reset current email -> get response (boolean)
    func resetVistorEmail(_ email: String) -> Bool
}


class VisitorManager  {
    
    var apiManager:  APIManaging!
    var dataManager: DataManaging!
    
//    func getLastVisitorEmail() -> String? {
//
//    }
//
//    func isRegisteredVisitor(_ email: String) -> [Any]? {
//
//    }
//
//    func getHashValueForVisitor(_ email: String, password: String) -> String {
//
//    }
//
//    func registerNewVisitor(_ fname: String, lname: String?, phone: String, dateOfBirth: String) -> Bool {
//
//    }
//
//    func resetVistorEmail(_ email: String) -> Bool {
//
//    }
    
}
