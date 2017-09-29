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
    
    // MARK: - Properties -
    var isKBShown: Bool = false
    var kbFrameSize: CGFloat = 0
    
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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneTF.addTarget(self, action: #selector(RegistrationVC.textFieldDidChange(textField:)), for: .editingChanged)
        phoneTF?.addPoleForButtonsToKeyboard(myAction: #selector(phoneTF.resignFirstResponder), buttonNeeds: true)
        ageTF?.addPoleForButtonsToKeyboard(myAction: #selector(ageTF.resignFirstResponder), buttonNeeds: true)
        
        //registerForKeyboardNotifications()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: 375, height: 1500)
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func kbWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbFrame = (userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        kbFrameSize = kbFrame.height
        UIView.animate(withDuration:0.3) {
            if !self.isKBShown {
                self.view.frame.origin.y -= self.kbFrameSize
            }
        }
        self.isKBShown = true
    }
    
    @objc func kbWillHide() {
        UIView.animate(withDuration:0.3) {
            if self.isKBShown {
                self.view.frame.origin.y += self.kbFrameSize
            }
        }
        self.isKBShown = false
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == phoneTF {
            
            return checkPhoneNumber(textField, shouldChangeCharactersIn: range, replacementString: string)
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
        
    }
    
    func checkPhoneNumber(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let validationSet = NSCharacterSet.decimalDigits.inverted
        let components = string.components(separatedBy: validationSet)
        print(components)
        
        guard components.count == 1 else { return false }
        
        guard var newString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return false }
        
        let validComponents = newString.components(separatedBy: validationSet)
        newString = validComponents.joined(separator: "")
        
        let localNumberMaxLength = 7
        let areaCodeMaxLength = 3
        let countryCodeMaxLength = 3
        
        if newString.count > (localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
            return false
        }
        
        var resultString = ""
        let localNumberLength = min(newString.count, localNumberMaxLength)
        
        if localNumberLength > 0 {
            let offset = newString.count - localNumberLength
            let number = String(describing: newString.suffix(from: String.Index.init(encodedOffset: offset)))
            resultString.append(number)
            
            if resultString.count > 5 {
                resultString.insert("-", at: String.Index.init(encodedOffset: 5)) // XXXXX-XX
            }
            
            if resultString.count > 3 {
                resultString.insert("-", at: String.Index.init(encodedOffset: 3)) // XXX-XX-XX
            }
        }
        
        if newString.count > localNumberLength {
            let areaCodeLength = min((newString.count - localNumberMaxLength), areaCodeMaxLength)
            let start = newString.index(newString.startIndex, offsetBy: (newString.count - localNumberMaxLength - areaCodeLength))
            let end = newString.index(newString.startIndex, offsetBy: (newString.count - localNumberMaxLength))
            let area = "(\(newString[start..<end])) "
            
            resultString = "\(area)\(resultString)"
        }
        
        if newString.count > localNumberLength + areaCodeMaxLength {
            
            let countryCodeLength = min((newString.count - localNumberMaxLength - areaCodeMaxLength), countryCodeMaxLength)
            let countryCode = "+\(newString[newString.index(newString.startIndex, offsetBy: 0)..<newString.index(newString.startIndex, offsetBy: countryCodeLength)]) "
            resultString = "\(countryCode)\(resultString)"
        }
        
        textField.text = resultString
        
        return false
    }
}
