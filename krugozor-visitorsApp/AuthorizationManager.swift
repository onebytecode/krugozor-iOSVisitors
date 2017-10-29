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
    func visitorRegistrationWith(data: VisitorAuthorizationData) -> String?
    func visitorLogInWith(data: VisitorAuthorizationData)  -> String?

}

class AuthorizationManager {
    
    
    
    
    
}
