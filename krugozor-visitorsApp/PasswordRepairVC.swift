//
//  PasswordRepairVC.swift
//  krugozor-visitorsApp
//
//  Created by Stanly Shiyanovskiy on 28.09.17.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import UIKit

class PasswordRepairVC: UIViewController, Alertable {
    
    var model = VisitorManager()

    static func storyboardInstance() -> PasswordRepairVC? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "PasswordRepairVC") as? PasswordRepairVC
    }

    // MARK: - Properties -
    var email: String?

    // MARK: - Outlets -
    @IBOutlet weak var emailTF: UITextField! {
        didSet {
            emailTF.text = email ?? ""
            emailTF.useUnderline()
        }
    }
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Actions -
    @IBAction func resetPswdBtn(_ sender: UIButton) {
        guard emailTF.text != "" else { showAlert(title: AlertTitle.emptyField.rawValue, message: "Введите e-mail для сброса пароля. Поле с e-mail не может быть пустым!", actionTitle: AlertActionTitle.ok.rawValue); return }
        emailTF.resignFirstResponder()
        let reset = model.resetVistorEmail(emailTF.text!)
        showAlertWithHandler(title: AlertTitle.resetPassword.rawValue, message: "Ваш пароль будет сброшен. Новый пароль будет выслан на указанную Вами почту", actionTitle: AlertActionTitle.ok.rawValue) { [weak self] in
            if reset { self?.backBtn.sendActions(for: .touchUpInside) }
        }
    }

    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
