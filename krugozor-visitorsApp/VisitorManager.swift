//
//  VisitorManager.swift
//  krugozor-visitorsApp
//
//  Created by Alexander Danilin on 21/10/2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation

protocol VisitorManaging {
    
    func currentVisitorEmail() -> String?
    func isRegisteredVisitor(_ email: String, _ password: String) -> Bool
    // 3. send visitor's email & password -> get sessionToken response
    func visitorLogIn(_ email: String, password: String)
    // 4. register new visitor's with name, last name (optional), phone number & date of birth -> get response (like a boolean true/false)
    func registerNewVisitor(_ fname: String, lname: String?, phone: String, dateOfBirth: String) -> Bool
    // 5. reset current email
    func resetVistorEmail(_ email: String) -> Bool
    // convert emalTF.text & passwordTF.text to VisitorRegistrationDataModel for transfering it to another VC
    func parseDataToModel(_ email: String, _ password: String) -> VisitorRegistrationData
}


class VisitorManager  {
    
    var apiManager:  APIManaging!
    var dataManager: DataManaging!
    
    func currentVisitorEmail() -> String? {
        
        return nil
    }

    func isRegisteredVisitor(_ email: String, _ password: String) -> Bool {
        // if is TRUE, ask to get sessionToken
        visitorLogIn(email, password: password)
        return false
    }
    
    func visitorLogIn(_ email: String, password: String) {
        // TODO: send visitors email & password to get token response
        // save sessionToken in the DB or UserDefaults, I think it needn't to return it's value...
        let sessionToken = ""
    }
    
    func registerNewVisitor(_ fname: String, lname: String?, phone: String, dateOfBirth: String) -> Bool {
        
        return true
    }
    
    func resetVistorEmail(_ email: String) -> Bool {
        // reset password for email and return TRUE if operation finished successfully
        return true
    }
    
    func parseDataToModel(_ email: String, _ password: String) -> VisitorRegistrationData {
        let model = VisitorRegistrationData(email: email, password: password)
        return model
    }
    
}
