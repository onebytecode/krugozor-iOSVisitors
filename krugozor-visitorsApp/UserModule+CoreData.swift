//
//  UserModule+CoreData.swift
//  anticafe-UserApp
//
//  Created by Анатолий on 25.09.17.
//  Copyright © 2017 OneByteCode. All rights reserved.
//

import CoreData

extension UserModule {
    func saveUserData (newUserInfo: UserDataStruct) {
        if let context = container?.viewContext {
            UserData.saveUserData(userInfo: newUserInfo, context: context)
        }
    }

    func restoreUserData () -> UserDataStruct? {
        if let context = container?.viewContext {
            let userData = UserData.restoreUserData(context: context)
            return (userData.isEmpty ? nil : userData)
        }
        return nil
    }

    func restoreUserData (fetchBy filter: UserRequestType, withText text: String) -> UserDataStruct? {
        if let context = container?.viewContext {
            let userData = UserData.restoreUserDataByCoincidences(predicateType: filter, predicateText: text, context: context)
            return (userData.isEmpty ? nil : userData)
        }
        return nil
    }
}
