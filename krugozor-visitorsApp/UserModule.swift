//
//  UserModule.swift
//  anticafe-UserApp
//
//  Created by Анатолий on 25.09.17.
//  Copyright © 2017 OneByteCode. All rights reserved.
//

import CoreData
import UIKit

protocol UserModuleProtocol {
    func saveUserData (newUserInfo: UserDataStruct)
    func registrationNewUser (newUser: UserDataStruct)
    func restoreUserData () -> UserDataStruct?
    func restoreUserData (fetchBy filter: UserRequestType, withText text: String) -> UserDataStruct?
    func recoverPassword (by id: String)
    func checkUserInServer (byUID id: String) -> UserDataStruct?
}

class UserModule: UserModuleProtocol {

    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    var network: RequestToServerProtocol?

    /// Checks the presence of the user in CoreData, if it is not there, goes to the server checks there.
    /// Need response in GCD not main treads
    func checkUserByUID (_ id: String) -> UserDataStruct? {
        if let userInfo = restoreUserData(fetchBy: .email, withText: id) {
            return userInfo
        } else {
            return checkUserInServer(byUID: id)
        }
    }
    
    /// Sends request to memory and server
    func registrationNewUser (newUser: UserDataStruct) {
        //saveUserData (newUserInfo: newUser)
        sendUserInfoToServer (newUserInfo: newUser)
    }
}
