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
  case Error
}

protocol VisitorManaging {
    
    func currentVisitorEmail() -> String?
    func isRegisteredVisitor(_ email: String, _ password: String) -> Bool
    func visitorLogInWith(data: VisitorAuthorizationData) -> Visitor
    func registerNewVisitorBy(data: VisitorAuthorizationData) -> Visitor
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
    
//    func visitorLogInWith(data: VisitorAuthorizationData) throws  -> Visitor {
//   
//    }
//    
//    func registerNewVisitor(data: VisitorAuthorizationData) throws -> Visitor {
// 
//    }
//    
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
