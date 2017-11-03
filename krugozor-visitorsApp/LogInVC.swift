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
        guard let emailValue = try? model.currentVisitorEmail() else { emailTF.text = ""; return }
        emailTF.text = emailValue
    }

    // MARK: - Actions -
    @IBAction func loginBtn(_ sender: UIButton) {

        // проверка email и пароля на пустые поля
        guard (emailTF.text != "" && passwordTF.text != "") else {
            showAlert(title: AlertTitle.emptyField.rawValue, message: "Email's or password's field is empty", actionTitle: AlertActionTitle.ok.rawValue)
            return
        }

        guard (emailTF.text?.isValidEmail())! else {
            showAlert(title: AlertTitle.wrongValue.rawValue, message: "Email is incorrect", actionTitle: AlertActionTitle.ok.rawValue)
            return
        }

        guard let digits = passwordTF.text?.count, digits >= 6 else {
            showAlert(title: AlertTitle.wrongValue.rawValue, message: "Minimum password length shoud be 6 characters", actionTitle: AlertActionTitle.ok.rawValue)
            return
        }

        // Убираем клавиатуру
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        
        let data = VisitorAuthorizationData(email: emailTF.text!, password: passwordTF.text!)
        
        // check if visitor is registered, open app; if no - open registration VC
        model.isRegisteredVisitorBy(email: emailTF.text!) { [weak self] (registered, error) in
            guard error == nil else { return }
            if registered != nil, registered == true {
                self?.model.visitorLogInWith(data: data, completion: { [weak self] (visitor, error) in
                    guard error != nil else { return }
                    if let newVC = TabBarViewController.storyboardInstance() {
                        self?.present(newVC, animated: true)
                    }
                })
            } else if registered != nil, registered == false {
                if let registrationVC = RegistrationVC.storyboardInstance() {
                    registrationVC.model = self?.model.parseLoginDataToModel((self?.emailTF.text!)!, (self?.passwordTF.text!)!)
                    self?.present(registrationVC, animated: true)
                }
            }
        }
    }

    @IBAction func forgotPswdBtn(_ sender: UIButton) {
        if let passwordVC = PasswordRepairVC.storyboardInstance() {
            passwordVC.email = emailTF.text
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
    }
}
