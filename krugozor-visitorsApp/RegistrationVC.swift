//
//  RegistrationVC.swift
//  krugozor-visitorsApp
//
//  Created by Stanly Shiyanovskiy on 26.09.17.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate, Alertable {
    
    static func storyboardInstance() -> RegistrationVC? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "RegistrationVC") as? RegistrationVC
    }
    
    // MARK: - Properties -
    var kbFrameSize: CGFloat = 0
    var popDatePicker : PopDatePicker?
    var model: VisitorAuthorizationData!
    
    // MARK: - Outlets -
    @IBOutlet weak var nameTF: UITextField! { didSet { nameTF.useUnderline() } }
    @IBOutlet weak var lastNameTF: UITextField! { didSet { lastNameTF.useUnderline() } }
    @IBOutlet weak var phoneTF: UITextField! { didSet { phoneTF.useUnderline() } }
    @IBOutlet weak var ageTF: UITextField! { didSet { ageTF.useUnderline() } }
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTF?.addPoleForButtonsToKeyboard(myAction: #selector(phoneTF.resignFirstResponder), buttonNeeds: true)
        ageTF?.addPoleForButtonsToKeyboard(myAction: #selector(ageTF.resignFirstResponder), buttonNeeds: true)
        popDatePicker = PopDatePicker(forTextField: ageTF)
        // imgUser gesture
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        avatarImg?.isUserInteractionEnabled = true
        avatarImg?.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(handleScreenTapHideKeyboard(sender:)))
        self.view.addGestureRecognizer(tapGestureHideKeyboard)
        
        self.scrollView.delegate = self
        registerForKeyboardNotifications()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func handleScreenTapHideKeyboard(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let curFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY =  curFrame.origin.y - targetFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
            
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: deltaY, right: 0)
            self.scrollView.contentInset = contentInsets
            
        }, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        avatarImg.image = info[UIImagePickerControllerEditedImage] as? UIImage
        avatarImg.contentMode = .scaleAspectFill
        avatarImg.layer.cornerRadius = avatarImg.frame.height / 2
        avatarImg.clipsToBounds = true
        model.avatar = UIImageJPEGRepresentation(avatarImg.image!, 1.0)
        dismiss(animated: true, completion: nil)
    }
    
    func chooseImagePickerAction(source: UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // MARK: - Actions -
    @IBAction func registerBtn(_ sender: UIButton) {
        self.view.endEditing(true)
        sendUserData ()
    }
    
    /// Send User Data to Server
    private func sendUserData () {
        if fieldsCheck() {
            let visitorManager = VisitorManager()
            let result = visitorManager.registerNewVisitor(model.fname, lname: model.lname ?? "", phone: model.phoneNumber, dateOfBirth: model.phoneNumber)
            if result { segueToAppMainMenu () }
        } else {
            showAlert(title: AlertTitle.emptyField.rawValue, message: "Поля не могут быть пустыми!", actionTitle: AlertActionTitle.ok.rawValue)
        }
    }
    
    /// Segue to TabBarViewController
    private func segueToAppMainMenu () {
        if let newVC = TabBarViewController.storyboardInstance() {
            self.present(newVC, animated: true, completion: nil)
        }
    }
    
    //Дописал метод с проверками
    /// Checking user input fields
    func fieldsCheck () -> Bool {
        let registrationManager = RegistrationManager()
        registrationManager.visitorModel = model
        return true
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        let ac = UIAlertController(title: "Select images source", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
            self.chooseImagePickerAction(source: .camera)
        }
        let photoLibAction = UIAlertAction(title: "Photos", style: .default) { (_) in
            self.chooseImagePickerAction(source: .photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cameraAction)
        ac.addAction(photoLibAction)
        ac.addAction(cancelAction)
        self.present(ac, animated: true, completion: nil)
    }
    
    // MARK: - TextFieldDelegate -
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func resign() {
        nameTF.resignFirstResponder()
        lastNameTF.resignFirstResponder()
        phoneTF.resignFirstResponder()
        ageTF.resignFirstResponder()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField === ageTF) {
            resign()
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            let initDate : Date? = formatter.date(from: ageTF.text!)
            
            let dataChangedCallback : PopDatePicker.PopDatePickerCallback = { [weak self] (newDate : Date, forTextField : UITextField) -> () in
                
                forTextField.text = (newDate.toString() ?? "?") as String
                self?.model.birthDate = forTextField.text
            }
            
            popDatePicker!.pick(self, initDate: initDate, dataChanged: dataChangedCallback)
            
            return false
        }
        else {
            return true
        }
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
            let result = String().checkPhoneNumber(textField.text!, in: range, replacement: string)
            textField.text = result.1
            return result.0
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == phoneTF && textField.text == "" {
            textField.text = "+7 "
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if textField == nameTF {
            model.fname = nameTF.text!
        } else if textField == phoneTF {
            model.phoneNumber = phoneTF.text!
        } else if textField == lastNameTF {
            model.lname = lastNameTF.text!
        }
    }

    
}
