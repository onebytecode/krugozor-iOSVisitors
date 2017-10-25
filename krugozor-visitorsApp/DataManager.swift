//
//  DataManager.swift
//  krugozor-visitorsApp
//
//  Created by Alexander Danilin on 21/10/2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation
import RealmSwift

public enum DataErrors: String, Error {
    case noCurrentVisior = "ERROR: No Current Visitor In DB!"
}

protocol DataManaging {
    
    func currentVisitor () throws -> Visitor 
}

/// Manages All Data In App; Guarantees Data Relevance
class DataManager {
    
    
    public func currentVisitor () throws -> Visitor? {
    
        let realm = try Realm()
        guard let currentVisitor = realm.object(ofType: Visitor.self, forPrimaryKey: 1) else { log.error(DataErrors.noCurrentVisior.rawValue); throw DataErrors.noCurrentVisior }
        return currentVisitor
    }
}
