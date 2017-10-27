//
//  RegistrationManager.swift
//  krugozor-visitorsApp
//
//  Created by Alexander Danilin on 21/10/2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation

protocol RegistrationManaging {
    
    func isVisitorRegisteredBy(email: String) -> Bool?
    func visitorRegistrationWith(data: VisitorAuthorizationData) -> String?
}

class RegistrationManager: RegistrationManaging {
  
    
    // MARK: RegistrationManaging Protocol
    func isVisitorRegisteredBy(email: String) -> Bool? {
        return false

    }
    
    func visitorRegistrationWith(data: VisitorAuthorizationData) -> String? {
        return ""

    }
}
