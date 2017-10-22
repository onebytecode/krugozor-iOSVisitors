//
//  RegistrationModel.swift
//  krugozor-visitorsApp
//
//  Created by Stanly Shiyanovskiy on 10.10.17.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation

protocol RegistrationProtocol {
    func checkAllFields() -> Bool
}

class RegistrationModel: RegistrationProtocol {
    
    var visitorRegData = VisitorRegistrationData!
    
    func checkAllFields() -> Bool {
        // FIXME: Проверять поля пользователя для продолжения либо регистрации, либо входа
        guard visitorRegData.lname != nil && visitorRegData.phoneNumber != nil && visitorRegData.birthDate != nil else { print("some fields are empty"); return false }
        print("all fields are full")
        return true
    }
}
