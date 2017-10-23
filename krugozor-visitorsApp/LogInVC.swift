//
//  LogInVC.swift
//  krugozor-visitorsApp
//
//  Created by Stanly Shiyanovskiy on 26.09.17.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import UIKit

class LogInVC: UIViewController, UITextFieldDelegate, Alertable {
    
    var model: VisitorManager!

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
        model = VisitorManager()
        emailTF.text = model.
    }

    // MARK: - Actions -
    @IBAction func loginBtn(_ sender: UIButton) {

        // проверка email и пароля на пустые поля
        guard (emailTF.text != "" && passwordTF.text != "") else {
            showAlert(title: "Warning!", message: "Email's or password's field is empty", actionTitle: "Ok")
            return
        }

        guard (emailTF.text?.isValidEmail())! else {
            showAlert(title: "Warning!", message: "Email is incorrect", actionTitle: "Ok")
            return
        }

        guard let digits = passwordTF.text?.count, digits >= 6 else {
            showAlert(title: "Warning!", message: "Minimum password length shoud be 6 characters", actionTitle: "Ok")
            return
        }

        // Убираем клавиатуру
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()

        if let registrationVC = RegistrationVC.storyboardInstance() {
            registrationVC.model = RegistrationModel()
            registrationVC.model.userDataStruct.email = emailTF.text
            // FIXME: добавить еще пароль для переноса в структуре на экран регистрации
            // registrationVC.model.userDataStruct.password = passwordTF.text
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

    @objc func textFieldDidChange(textField: UITextField) {
        guard let email = textField.text, email.isValidEmail() else { return } 
        model.userExistenceCheck(email)
    }
}

protocol LogInVCDelegate {
    weak var emailTF: UITextField! {get set}
}
