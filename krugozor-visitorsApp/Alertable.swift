//
//  Alertable.swift
//  krugozor-visitorsApp
//
//  Created by Anton Novoselov on 12/10/2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import UIKit

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
}


