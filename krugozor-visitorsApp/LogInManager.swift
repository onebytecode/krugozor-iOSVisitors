//
//  LogInService.swift
//  krugozor-visitorsApp
//
//  Created by Alexander Danilin on 21/10/2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation

protocol LogInManaging {
    
    func visitorLogInWith(data: VisitorAuthorizationData)  -> String?
}

class LogInManager: LogInManaging {
    
    
    // MARK: LogInManaging Protocol
    public func visitorLogInWith(data: VisitorAuthorizationData)  -> String? {
        return ""
    }
}


