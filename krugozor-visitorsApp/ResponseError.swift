//
//  ResponseError.swift
//  krugozor-visitorsApp
//
//  Created by Анатолий on 28.09.2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation

/// Error type class
class ResponseError {
    let code: Int?
    let message: String?

    /// Init with json object from request
    init(json: Any?) {
        guard let obj = json as? [String: Any] else {
            code = nil
            message = nil
            return
        }
        code = obj["code"] as? Int
        message = String(describing: obj["message"])
    }
}
