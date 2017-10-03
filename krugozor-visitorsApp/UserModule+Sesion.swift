//
//  UserModule+UserSesion.swift
//  krugozor-visitorsApp
//
//  Created by Анатолий on 29.09.2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import CoreData

extension UserModule {
    
    /// Returns the login of the user with the last session
    func userLastSession () -> String? {
        if let context = container?.viewContext {
            let userData = UserData.restoreLastSession(context: context)
            return userData.email // if email is -> login?
        }
        print("Can't create a context")
        return nil
    }
    
    /// Delete last session and all user info from memory
    func deleteUserSession () {
        if let context = container?.viewContext {
            UserData.deleteAllUsers(context: context)
        }
        print("Can't create a context")
    }
}

