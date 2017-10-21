//
//  Visit.swift
//  krugozor-visitorsApp
//
//  Created by Alexander Danilin on 21/10/2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation
import RealmSwift

class Visit: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var startAt = ""
    @objc dynamic var startDate = ""
    @objc dynamic var finishDate = ""
    @objc dynamic var duration = 0
    @objc dynamic var totalPrice = 0
}
