//
//  RegistrationManager.swift
//  krugozor-visitorsApp
//
//  Created by Alexander Danilin on 21/10/2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation

protocol RegistrationManaging {
    
    func isVisitorRegisteredBy(email: String, completion: @escaping (_ result: Bool) -> Void)
    func visitorRegistrationWith(data: VisitorAuthorizationData) -> String?
}

class RegistrationManager {
    
    let apiManager = APIManager()
    
    // MARK: RegistrationManaging Protocol
    func isVisitorRegisteredBy(email: String, completion: @escaping (_ result: Bool) -> Void) {
        apiManager.isVisitorRegisteredBy(email: email) { (result) in
            return result
        }
    }
    
    func visitorRegistrationWith(data: VisitorAuthorizationData) -> String? {
        return ""

    }
}
