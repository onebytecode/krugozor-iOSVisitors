//
//  RegistrationVC.swift
//  krugozor-visitorsApp
//
//  Created by Stanly Shiyanovskiy on 26.09.17.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController, UITextFieldDelegate {
    
    static func storyboardInstance() -> RegistrationVC? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "RegistrationVC") as? RegistrationVC
    }
    
    // MARK: - Outlets -
    @IBOutlet weak var nameTF: UITextField! {
        didSet {
            nameTF.useUnderline()
        }
    }
    
    @IBOutlet weak var lastNameTF: UITextField! {
        didSet {
            lastNameTF.useUnderline()
        }
    }
    
    @IBOutlet weak var phoneTF: UITextField! {
        didSet {
            phoneTF.useUnderline()
        }
    }
    
    @IBOutlet weak var ageTF: UITextField! {
        didSet {
            ageTF.useUnderline()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTF.addTarget(self, action: #selector(RegistrationVC.textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    // MARK: - Actions -
    @IBAction func registerBtn(_ sender: UIButton) {
        print("register button pressed")
    }
    
    // MARK: - TextFieldDelegate -
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTF {
            nameTF.resignFirstResponder()
            lastNameTF.becomeFirstResponder()
        } else if textField == lastNameTF {
            lastNameTF.resignFirstResponder()
            phoneTF.becomeFirstResponder()
        } else if textField == phoneTF {
            phoneTF.resignFirstResponder()
            ageTF.becomeFirstResponder()
        } else {
            ageTF.resignFirstResponder()
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
    
    @objc func textFieldDidChange(textField: UITextField){
        if textField.text != "" {
            phoneTF.text = textField.text?.checkPhoneNumberFormat()
        }
    }
}
