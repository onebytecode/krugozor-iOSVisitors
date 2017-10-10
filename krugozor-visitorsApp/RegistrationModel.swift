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
    
    var userDataStruct = UserDataStruct()
    
    func checkAllFields() -> Bool {
        // FIXME: Проверять поля пользователя для продолжения либо регистрации, либо входа
        guard userDataStruct.name != nil && userDataStruct.phoneNumber != nil && userDataStruct.birthDate != nil && userDataStruct.photoImageOrigin != nil else { print("some fields are empty"); return false }
        print("all fields are full")
        return true
    }
}
