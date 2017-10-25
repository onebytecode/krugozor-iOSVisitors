//
//  GQLMethod.swift
//  krugozor-visitorsApp
//
//  Created by Alexander Danilin on 25/10/2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation

protocol GQLMethod {
    
    func methodType () -> String
}

enum Query: String {
    
    func methodType() -> String {
        return "query{"
    }
    
    case visitor = "Visitor"
}


enum Mutation: String, GQLMethod {
    
    func methodType() -> String {
        return "mutation{"
    }
    
    
    case registerNewVisitor = "registerNewVisitor"
    case visitorLogIn = "visitorLogIn"
    case visitorLogOut = "visitorLogOut"
}


