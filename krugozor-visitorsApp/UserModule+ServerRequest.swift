//
//  UserModule+Network.swift
//  anticafe-UserApp
//
//  Created by Анатолий on 25.09.17.
//  Copyright © 2017 OneByteCode. All rights reserved.
//

import Foundation

extension UserModule {

    func checkUserInServer (byUID id: String) -> UserDataStruct {
        network = RequestToServer.shared()
        return (network?.checkUserOnServer(byUID: id))!
    }
}

