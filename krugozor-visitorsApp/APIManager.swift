//
//  ApiManager.swift
//  krugozor-visitorsApp
//
//  Created by Alexander Danilin on 21/10/2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol APIManaging {
 
    func isVisitorRegisteredBy(email: String, completion: @escaping (_ result: Bool) -> Void)
}

/// Default Layer Class For Server Interaction
class APIManager: APIManaging {
    
    func isVisitorRegisteredBy(email: String, completion: @escaping (_ result: Bool) -> Void) {
        
        let gqlParams = [GQLParam.init(key: GQLVisitor.email.rawValue, value: email)]
        let gqlArgumant = [GQLArgument.init(key: "id")]
        var gql = String()
        
        do {
         gql = try GQLBuilder.build(query: Query.visitor, mutation: nil, params: gqlParams, arguments: gqlArgumant)
        } catch let error { log.error(error) }
        let parameters: Parameters = ["query" : gql]
        
        Alamofire.request(URLBuilder.gqlHost, method: .get, parameters: parameters).responseJSON { response in
            switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if json["data"]["getVisitor"]["id"].string != nil {
                        completion(true)
                    } else {
                        completion(false) }
                case .failure(let error):
                    log.error(error)
                }
        }
    }
}
