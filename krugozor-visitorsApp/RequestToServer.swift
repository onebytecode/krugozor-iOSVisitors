//
//  NetworkConnection.swift
//  anticafe-UserApp
//
//  Created by Анатолий on 25.09.17.
//  Copyright © 2017 OneByteCode. All rights reserved.
//

import Foundation

protocol RequestToServerProtocol {
    static func shared() -> RequestToServer
    func checkUserOnServer (byUID id: String) -> UserDataStruct
    func registredNewUser (userData: UserDataStruct)
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
        if responseToServerByID(id) {
            return responseGetDataFromUID(id)
        } else {
            return registerNewUser ()
        }
    }

    /// Request of UID of user to the server
    fileprivate func responseToServerByID (_ id: String) -> Bool {
        // enter response text
        return true // Requires replacement
    }

    // Here we need to create a data structure that will be stored on the server as information about our user
    fileprivate func responseGetDataFromUID (_ id: String) -> UserDataStruct {
        //response text to get data
        return UserDataStruct() // Requires replacement
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
}
