//
//  RegistrationManager.swift
//  krugozor-visitorsApp
//
//  Created by Alexander Danilin on 21/10/2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation

protocol RegistrationManaging {
    
    // check if all fileds for correct registration are filled up
    func checkAllFields() -> Bool
    
}

class RegistrationManager {
    
    var visitorModel: VisitorRegistrationData!
    
    func checkAllFields() -> Bool {
        guard visitorModel.fname != nil && visitorModel.phoneNumber != nil && visitorModel.birthDate != nil else { print("RegistrationManager -> some fields are empty"); return false }
        print("RegistrationManager -> all fields are full")
        return true
    }
}
