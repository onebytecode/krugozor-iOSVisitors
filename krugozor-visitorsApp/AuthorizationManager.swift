//
//  AuthorizationManager.swift
//  krugozor-visitorsApp
//
//  Created by Alexander Danilin on 29/10/2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation

protocol AuthorizationManaging  {
    
    func isVisitorRegisteredBy(email: String, completion: @escaping (_ result: Bool) -> Void)
    func visitorRegistrationWith(data: VisitorAuthorizationData, completion: @escaping (_ sessionToken: Bool) -> Void)
    func visitorLogInWith(data: VisitorAuthorizationData, completion: @escaping (_ sessionToken: Bool) -> Void)
}

class AuthorizationManager {
    
//    let api = APIManager()
//
//    public func isVisitorRegisteredBy(email: String, completion: @escaping (_ result: Bool) -> Void) {
//        self.api.isVisitorRegisteredBy(email: email) { (result) in
//            return completion(result)
//        }
//    }
//
//    public func visitorRegistrationWith(data: VisitorAuthorizationData, completion: @escaping (_ sessionToken: Bool) -> Void) {
//
//    }
//
//
//    public func visitorLogInWith(data: VisitorAuthorizationData, completion: @escaping (_ sessionToken: Bool) -> Void) {
//
//
//    }
}

