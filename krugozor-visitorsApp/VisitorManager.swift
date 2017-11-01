//
//  VisitorManager.swift
//  krugozor-visitorsApp
//
//  Created by Alexander Danilin on 21/10/2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation

/// Version 0.0.2

//  For Version 1.0.0
//  TODO: Errors
//  TODO: Functions Return Escaping
//  TODO: Logging

public enum VisitorManagerErrors: String, Error {
    case Error = ""
    case Error2 = "2"
}

protocol VisitorManaging {
    
    func currentVisitorEmail() -> String?
    
    func isRegisteredVisitor(_ email: String, _ password: String, completion: @escaping ((_ result: Bool?, _ error: VisitorManagerErrors?) -> Void))
    func visitorLogInWith(data: VisitorAuthorizationData, completion: @escaping ((_ sessionToken: String?, _ error: VisitorManagerErrors?) -> Void))
    func registerNewVisitorBy(data: VisitorAuthorizationData, completion: @escaping ((_ visitor: Visitor?, _ error: VisitorManagerErrors?) -> Void))
    
    func parseLoginDataToModel(_ email: String, _ password: String) -> VisitorAuthorizationData
}

class VisitorManager {
    
    let authManager = AuthorizationManager()
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

    public func visitorLogInWith(data: VisitorAuthorizationData, completion: @escaping ((_ visitor: Visitor?, _ error: String?) -> Void)) {
        apiManager.visitorLogInWith(data: data) { (sessionToken, error) in
            guard (sessionToken != nil) else {return completion (nil, error)}
            log.debug(sessionToken)
            self.dataManager.fetchVisitorBy(sessionToken: sessionToken!, completion: { (visitor, error) in
                guard (visitor != nil) else {log.error(error as Any); return completion (nil, error)}
            })
        }
    }

//    func registerNewVisitor(data: VisitorAuthorizationData) throws -> Visitor {
// 
//    }

//    func parseRegistrationDataToModel() -> VisitorAuthorizationData {
//        
//    }
    
    func parseLoginDataToModel(_ email: String, _ password: String) -> VisitorAuthorizationData {
        let model = VisitorAuthorizationData(email: email, password: password)
        return model
    }

    public func isRegisteredVisitorFor(email: String, completion: @escaping (_ result: Bool, _ error: VisitorManagerErrors) -> Void) {
      
    }
}
