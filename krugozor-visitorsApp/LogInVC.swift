//
//  LogInVC.swift
//  krugozor-visitorsApp
//
//  Created by Stanly Shiyanovskiy on 26.09.17.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import UIKit

class LogInVC: UIViewController, UITextFieldDelegate, LogInVCDelegate {
    
    var model: LoginVCModelProtocol!

    static func storyboardInstance() -> LogInVC? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "LogInVC") as? LogInVC
    }

    // MARK: - Properties -
    var itemIndex: Int = 0

    // MARK: - Outlets -
    @IBOutlet weak var emailTF: UITextField! {
        didSet {
            emailTF.useUnderline()
        }
    }

    @IBOutlet weak var passwordTF: UITextField! {
        didSet {
            passwordTF.useUnderline()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTF.addTarget(self, action: #selector(LogInVC.textFieldDidChange(textField:)), for: .editingChanged)
        model = LoginVCModel()
        model.delegate = self
        model.viewIsLoad()
    }

    // MARK: - Actions -
    @IBAction func loginBtn(_ sender: UIButton) {

        // проверка email и пароля на пустые поля
        guard (emailTF.text != "" && passwordTF.text != "") else {
            errorAlert(title: "Warning!", message: "Email's or password's field is empty", actionTitle: "Ok")
            return
        }

        guard (emailTF.text?.isValidEmail())! else {
            errorAlert(title: "Warning!", message: "Email is incorrect", actionTitle: "Ok")
            return
        }

        guard let digits = passwordTF.text?.count, digits >= 6 else {
            errorAlert(title: "Warning!", message: "Minimum password length shoud be 6 characters", actionTitle: "Ok")
            return
        }

        // Убираем клавиатуру
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()

        if let registrationVC = RegistrationVC.storyboardInstance() {
            self.present(registrationVC, animated: true, completion: nil)

        }
    }

    @IBAction func forgotPswdBtn(_ sender: UIButton) {
        if let passwordVC = PasswordRepairVC.storyboardInstance() {
            self.present(passwordVC, animated: true, completion: nil)
        }
    }

    @IBAction func showHidePswd(_ sender: UIButton) {

        guard passwordTF.text != "" else { return }
        UIView.animate(withDuration: 0.3) {
            self.passwordTF.isSecureTextEntry = !self.passwordTF.isSecureTextEntry
        }
    }

    // MARK: - TextFieldDelegate -
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTF {
            emailTF.resignFirstResponder()
            passwordTF.becomeFirstResponder()
        } else {
            passwordTF.resignFirstResponder()
        }
        return true
    }

    // MARK: - Private methods -
    func errorAlert(title: String, message: String, actionTitle: String) {
        let alertView = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle:. alert)
        let okAction = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alertView.addAction(okAction)
        present(alertView, animated: true, completion: nil)
    }

    @objc func textFieldDidChange(textField: UITextField) {
        guard let email = textField.text, email.isValidEmail() else { return } // с точкой разумнее проверять ИМХО
        model.userExistenceCheck(email)
        print("ask server to check email: \(textField.text!)")

    }
}

protocol LogInVCDelegate {
    weak var emailTF: UITextField! {get set}
}
