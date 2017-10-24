//
//  Alertable.swift
//  krugozor-visitorsApp
//
//  Created by Anton Novoselov on 12/10/2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import UIKit

public enum AlertTitle: String {
    case emptyField = "Пустое поле!"
    case wrongValue = "Неверное значение!"
    case resetPassword = "Сброс пароля"
}

public enum AlertActionTitle: String {
    case ok = "OK"
    case cancel = "Отмена"
}

protocol Alertable {}

extension Alertable where Self: UIViewController {
    
    
    
    func showAlert(title: String, message: String, actionTitle: String) {
        let alertView = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle:. alert)
        let okAction = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alertView.addAction(okAction)
        present(alertView, animated: true, completion: nil)
    }
    
    func showAlertWithHandler(title: String, message: String, actionTitle: String, handler: @escaping ()->() = { }) {
        let alertView = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle:. alert)
        let okAction = UIAlertAction(title: actionTitle, style: .default) { (action) in
            handler()
        }
        alertView.addAction(okAction)
        present(alertView, animated: true, completion: nil)
    }
}


