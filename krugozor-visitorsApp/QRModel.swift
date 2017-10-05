//
//  QRModel.swift
//  krugozor-visitorsApp
//
//  Created by Анатолий on 05.10.2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation

protocol QRModelProtocol {
    var userModule: UserModuleProtocol! {get set}
    func getUID () -> String
}

class QRModel: QRModelProtocol {
    
    var userModule: UserModuleProtocol!
    
    func getUID () -> String {
        guard let uid = userModule.restoreUserData()?.email else {
            print("Error - no User Data in Memory")
            return ""
        }
        return encodeUID(uid: uid)
    }
    
    fileprivate func encodeUID (uid: String) -> String {
        var encodeUID = String()
        for i in uid {
            encodeUID.append(i)
            encodeUID.append(".")
        }
        return encodeUID
    }
}









