//
//  GQLBuilder.swift
//  krugozor-visitorsApp
//
//  Created by Alexander Danilin on 21/10/2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation


public enum GQLErrors: String, Error {
    
    case noMethod = "ERROR: No Query Or Mutation Provided"
}

public struct GQLParam {
    
    let key: String!
    let value: String!
}

public struct GQLArgument {
    
    let key: String!
   
    public init(key: String!) {
        self.key = key
    }
}

protocol GQLBuilding {
    
    static func build () -> String
}

// TODO: To Test And Cover Tests
/// Builds GQL Parameters For APIManager
/// Version 0.0.1
/// Supports Basic Mutations and Queries
class GQLBuilder {
    
    /// STEP 1:
    /// STEP 2:
    /// STEP 3:
    public static func build(query: Query?, mutation: Mutation?, params: [GQLParam], arguments: [GQLArgument]) throws -> String {
        
        // STEP 1
        // Validation For Optonal Parameters Presence
        guard query != nil || mutation != nil else { throw GQLErrors.noMethod }
        // Main Function Return String
        var finalString = String()
        // Optional Chaining For Query
        if query != nil { switch query { default: finalString += query!.methodType() + query!.rawValue }}
        // Optional Chaining For Mutation
        if mutation != nil { switch mutation { default: finalString += mutation!.methodType() + mutation!.rawValue} }
        
        // STEP 2
        finalString += "("
        
        for param in params {
            if param.value != nil {
                finalString += param.key
                finalString += ":"
                finalString += ("\u{22}\(param.value!)\u{22}")
                finalString += "," } }

        finalString = String(finalString.characters.dropLast())
        finalString += "){"
        
        // STEP 3
        finalString += "\n"
        for argument in arguments { finalString += argument.key; finalString += "\n" }
        finalString += "}}"

        return finalString
    }
}
