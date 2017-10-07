//
//  LoginVCModel.swift
//  krugozor-visitorsApp
//
//  Created by Анатолий on 07.10.2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation

protocol LoginVCModelProtocol {
    var delegate: LogInVCDelegate! {get set}
    func viewIsLoad ()
    func userExistenceCheck (_ email: String)
}

class LoginVCModel: LoginVCModelProtocol {
    
    var userModule: UserModuleProtocol!
    var delegate: LogInVCDelegate!
    
    var userFullInfo: UserDataStruct? {
        didSet {
            //FIXME: Дописать. Вызывает в случае если пользователь найден на сервере и получены все данные
        }
    }
    
    func viewIsLoad () {
        userModule = UserModule()
        showEmail ()
    }
    
    /// Show user email
    func showEmail () {
        guard let lastUser = userModule.restoreUserData()?.email else { return }
        delegate.emailTF.text = lastUser
    }
    
    /// Check email on server
    func userExistenceCheck (_ email: String) {
        guard let info = userModule.checkUserInServer(byUID: email) else { return }
        userFullInfo = info
    }
}
