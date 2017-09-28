//
//  Response.swift
//  krugozor-visitorsApp
//
//  Created by Анатолий on 28.09.2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation

/// Type of responses received from the server
class Response {

    let data: Any?
    let code: Int?
    let message: String?
    let error: ResponseError?

    // MARK: - Root

    init?(json: Any?) {
        guard let obj = json as? [String : Any] else { return nil }

        code = obj["code"] as? Int
        message = obj["message"] as? String
        data = json
        error = ResponseError(json: json)
    }
}
