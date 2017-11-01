//
//  DataManager.swift
//  krugozor-visitorsApp
//
//  Created by Alexander Danilin on 21/10/2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

public enum DataErrors: String, Error {
    case noCurrentVisior = "ERROR: No Current Visitor In DB!"
}

protocol DataManaging {
    
    func currentVisitor () throws -> Visitor?
}

/// Manages All Data In App; Guarantees Data Relevance
class DataManager: DataManaging {
   
    let api = APIManager()
    
    // MARK: DataManaging Protocol
    func currentVisitor() throws -> Visitor? {
        let realm = try Realm()
        guard let currentVisitor = realm.object(ofType: Visitor.self, forPrimaryKey: 0) else { log.error(DataErrors.noCurrentVisior.rawValue); throw DataErrors.noCurrentVisior }
        return currentVisitor
    }
    
    
    func fetchVisitorBy(sessionToken: String, completion: @escaping ((_ visitor: Visitor?, _ error: String?) -> Void)) {
        api.fetchCurrentVisitorBy(sessionToken: sessionToken) { (visitor, error) in
            guard visitor != nil else { log.error(error); return completion(nil, error)}
            
            let realm = try! Realm()
            
            try! realm.write {
                realm.add(visitor!)
                completion(visitor, nil)
            }
        }
    }
}
