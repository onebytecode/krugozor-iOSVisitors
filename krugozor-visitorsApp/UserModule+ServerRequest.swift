//
//  UserModule+Network.swift
//  anticafe-UserApp
//
//  Created by Анатолий on 25.09.17.
//  Copyright © 2017 OneByteCode. All rights reserved.
//

import Foundation

extension UserModule {

    func checkUserInServer (byUID id: String) -> UserDataStruct? {
        network = RequestToServer.shared()
        return (network?.checkUserOnServer(byUID: id))
    }
    
    func sendUserInfoToServer (newUserInfo: UserDataStruct) {
        network = RequestToServer.shared()
        network?.registredNewUser(userData: newUserInfo)
    }
    
    func recoverPassword (by email: String) {
        guard email.isEmpty else { return }
        network = RequestToServer.shared()
        network?.requestForForgotten(email: email)
    }
}

