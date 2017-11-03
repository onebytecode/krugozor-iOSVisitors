//
//  VisitorManager.swift
//  krugozor-visitorsApp
//
//  Created by Alexander Danilin on 21/10/2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation

/// Version 0.1.0

//  For Version 1.0.0
//  TODO: Errors Suppot
//  TODO: Logging

public enum VisitorManagerErrors: String, Error {
    case Error1 = "1"
    case Error2 = "2"
    case Error3 = "3"
    case Error4 = "4"
}

protocol VisitorManaging {
    
    func currentVisitorEmail() throws  -> String?
    
    // Working
    func isRegisteredVisitorBy(email: String, completion: @escaping (_ result: Bool?, _ error: VisitorManagerErrors?) -> Void)
    // Working 
    func visitorLogInWith(data: VisitorAuthorizationData, completion: @escaping ((_ visitor: Visitor?, _ error: VisitorManagerErrors?) -> Void))
    // Working
    func registerNewVisitorBy(data: VisitorAuthorizationData, completion: @escaping ((_ visitor: Visitor?, _ error: VisitorManagerErrors?) -> Void))
    
    func parseLoginDataToModel(_ email: String, _ password: String) -> VisitorAuthorizationData
}

class VisitorManager: VisitorManaging {

    let apiManager = APIManager()
    let dataManager = DataManager()
   
    
    public func currentVisitorEmail() throws  -> String? {
        do {
            guard let currentVisitor = try dataManager.currentVisitor() else { log.error(DataErrors.noCurrentVisior); throw DataErrors.noCurrentVisior }
            return currentVisitor.email
        } catch let error {
            log.error(error)
            throw error
        }
    }

    /// Main Log In Entry Point
    ///
    /// - Parameters:
    ///   - data: VisitorAuthorizationData with Email & Password
    ///   - completion: Returns Chached Visior Model or Error
    public func visitorLogInWith(data: VisitorAuthorizationData, completion: @escaping ((_ visitor: Visitor?, _ error: VisitorManagerErrors?) -> Void)) {
        
        // Getting SessionToken Via API
        apiManager.visitorLogInWith(data: data) { (_sessionToken, _error) in
            
            guard (_sessionToken != nil) else { log.error(_error as Any); return completion (nil, VisitorManagerErrors.Error1)}
            
            // Getting Cached Visitor Via DataManager
            self.dataManager.fetchVisitorBy(sessionToken: _sessionToken!, completion: { (_visitor, _error) in
                
                guard (_visitor != nil) else {log.error(_error as Any); return completion(nil, VisitorManagerErrors.Error1)}
                
                return completion(_visitor, nil)
            })
        }
    }

    /// Main Registration Point; Auto Loging After Successful Registration
    ///
    /// - Parameters:
    ///   - data: VisitorAuthorizationData With Min Filled Properties
    ///   - completion: A Logged, Cached Visitor Model With SessionToken Inside
    func registerNewVisitorBy(data: VisitorAuthorizationData, completion: @escaping ((_ visitor: Visitor?, _ error: VisitorManagerErrors?) -> Void)) {
       
        // Registering Via API & Getting SessionToken
        self.apiManager.visitorRegistrationWith(data: data) { (_sessionToken, _error) in
            
            guard _sessionToken != nil else { log.error(_error as Any); return completion(nil, VisitorManagerErrors.Error1)}
            
            self.dataManager.fetchVisitorBy(sessionToken: _sessionToken!, completion: { (_visitor, _error) in
                
                guard _visitor != nil else { log.error(_error as Any); return completion(nil, VisitorManagerErrors.Error1)}
                return completion(_visitor, nil)
            })
        }
    }
    
    /// Checks is user registred on server by provided email
    ///
    /// - Parameters:
    ///   - email: Visitor Email
    ///   - completion: Bool of the answer; VisitorManagerError
    public func isRegisteredVisitorBy(email: String, completion: @escaping (_ result: Bool?, _ error: VisitorManagerErrors?) -> Void) {
        self.apiManager.isVisitorRegisteredBy(email: email) { (_result, _error) in
            guard _result != nil else {log.error(_error as Any); return completion(nil, VisitorManagerErrors.Error1)}
            return completion(_result, nil)
        }
    }
    
    func parseLoginDataToModel(_ email: String, _ password: String) -> VisitorAuthorizationData {
        let model = VisitorAuthorizationData(email: email, password: password)
        return model
    }

}
