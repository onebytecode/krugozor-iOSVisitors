//
//  UserModule.swift
//  anticafe-UserApp
//
//  Created by Анатолий on 25.09.17.
//  Copyright © 2017 OneByteCode. All rights reserved.
//

import CoreData

protocol UserModuleProtocol {
    func saveUserData (newUserInfo: UserDataStruct)
    func restoreUserData () -> UserDataStruct?
    func restoreUserData (fetchBy filter: UserRequestType, withText text: String) -> UserDataStruct?
}

class UserModule: UserModuleProtocol {

    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    var network: NetworkConnectionProtocol?

    /// Checks the presence of the user in CoreData, if it is not there, goes to the server checks there.
    /// Need response in GCD not main treads
    func checkUserByUID (_ id: String) -> UserDataStruct {
        if let userInfo = restoreUserData(fetchBy: .email, withText: id) {
            return userInfo
        } else {
            return checkUserInServer(byUID: id)
        }
    }
}
