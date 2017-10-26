//
//  VisitorManager.swift
//  krugozor-visitorsApp
//
//  Created by Alexander Danilin on 21/10/2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation

/// Version 0.0.1

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
    func parseDataToModel(_ email: String, _ password: String) -> VisitorAuthorizationData
}


class VisitorManager  {
    
    let apiManager = APIManager()
    let dataManager = DataManager()
    let registrationManager = RegistrationManager()
    let logInManager = LogInManager()
    
    public func currentVisitorEmail() throws  -> String? {

        do {
            guard let currentVisitor = try dataManager.currentVisitor() else { log.error(DataErrors.noCurrentVisior); throw DataErrors.noCurrentVisior}
            return currentVisitor.email
        } catch let error {
            log.error(error)
            throw error
        }
    }

    public func isRegisteredVisitorFor(email: String) throws -> Bool {
        
        guard let response = registrationManager.isVisitorRegisteredBy(email: email) else { throw VisitorManagerErrors.Error }
        return response
    }
    
    func visitorLogInWith(data: VisitorAuthorizationData) throws  -> Visitor {
        
        guard let sessionToken = logInManager.visitorLogInWith(data: data) else { throw VisitorManagerErrors.Error }
        do {
            let visitor = try dataManager.fetchVisitorBy(sessionToken: sessionToken); return visitor
        } catch let error { throw error }
    }
    
    func registerNewVisitor(data: VisitorAuthorizationData) throws -> Visitor {
        
        guard let sessionToken = registrationManager.visitorRegistrationWith(data: data) else { throw VisitorManagerErrors.Error }
        do {
            let visitor = try dataManager.fetchVisitorBy(sessionToken: sessionToken); return visitor
        } catch let error { throw error }
    }
    
    func parseDataToModel(_ email: String, _ password: String) -> VisitorAuthorizationData {
        
        let model = VisitorAuthorizationData(email: email, password: password)
        return model
    }
}
