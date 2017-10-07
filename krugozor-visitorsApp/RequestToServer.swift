//
//  NetworkConnection.swift
//  anticafe-UserApp
//
//  Created by Анатолий on 25.09.17.
//  Copyright © 2017 OneByteCode. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestToServerProtocol {
    static func shared() -> RequestToServer
    func checkUserOnServer (byUID id: String) -> UserDataStruct
    func registredNewUser (userData: UserDataStruct)
    func requestForForgotten(email: String)
}

class RequestToServer: RequestToServerProtocol {

    // MARK: Singletone
    private static var uniqueInstance: RequestToServer?

    private init() {}

    static func shared() -> RequestToServer {
        if uniqueInstance == nil {
            uniqueInstance = RequestToServer()
        }
        return uniqueInstance!
    }

    // MARK: Realization

    /// Checks for the presence of a registered user, if it does not find one, creates a new one
    func checkUserOnServer (byUID id: String) -> UserDataStruct {
        //FIXME: Response to server, and get or not user data
        return UserDataStruct()
    }

    // Initializes the process of registering a new user
    fileprivate func registerNewUser () -> UserDataStruct {
        // I suggest to create a closure, that will initialize the method in the view controller, that will eventually return the data structure that we need
        return UserDataStruct() // Requires replacement
    }
    
    /// Registred new User in Server
    func registredNewUser (userData: UserDataStruct) {
        // сконфигурировать запрос
        // добавить в alamofire
        // использовать Session Manager
    }
    
    func requestForForgotten(email: String) {
        // сконфигурировать запрос для забытого email
    }
}
