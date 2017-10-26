//
//  ApiManager.swift
//  krugozor-visitorsApp
//
//  Created by Alexander Danilin on 21/10/2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation
import Alamofire

protocol APIManaging {
    func isVisitorRegisteredBy(email: String) -> Bool
    func visitorLogInWith(data: VisitorAuthorizationData) -> String
    func visitorRegistrationWith(data: VisitorAuthorizationData) -> String
}

/// Default Layer Class For Server Interaction
class APIManager {
    
}
