//
//  Date+Extension.swift
//  krugozor-visitorsApp
//
//  Created by Stanly Shiyanovskiy on 07.10.17.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    func toString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: self)
    }
}
