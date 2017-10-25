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
    
}

/// Default Layer Class For Server Interaction
class APIManager {
    
    func isRegisteredVisitorFor(email: String) -> Bool {
        
        return false
    }
}
