//
//  GQLBuilder.swift
//  krugozor-visitorsApp
//
//  Created by Alexander Danilin on 21/10/2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation

/// Builds And Manages GQL Parameters For APIManager

enum GQLErrors : String, Error {
    case noMethod = "No method provided!"
    
}

class GQLBuilder {
    
    public static func buildGQLParamFor(query: Query?, mutation: Mutation?) throws -> String {
        
        // Validation For Optonal Parameters Presence
        guard query != nil || mutation != nil else { throw GQLErrors.noMethod }
        // Main Function Return String
        var finalString = String()
        // Optional Chaining For Query
        if query != nil { switch query {default: finalString += query!.methodType() + (query?.rawValue)!} } //TODO: .None Case Handling
        // Optional Chaining For Mutation
        if mutation != nil { switch mutation {default:  finalString += mutation!.methodType() + mutation!.rawValue} } //TODO: .None Case Handling
        
        
        
        
        
        
     
        
        
        
        
        
        
        return finalString
    }
    
    
}
        
  
    
    
//    private static func mutation(ForCase: Mutation) -> String {
//
//        var returnString = String()
//        returnString += Mutation.mutation
//
//        switch ForCase {
//
//            case .registerNewVisitor:  returnString += Mutation.registerNewVisitor.rawValue
//            case .visitorLogIn: returnString += Mutation.visitorLogIn.rawValue
//            case .visitorLogOut: returnString += Mutation.visitorLogOut.rawValue
//        }
//
//        return returnString
//    }
//
//
//
    
    
    


