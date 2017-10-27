//
//  AccountTVC.swift
//  krugozor-visitorsApp
//
//  Created by Stanly Shiyanovskiy on 27.10.17.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import UIKit

class AccountTVC: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, Alertable {
    
    static func storyboardInstance() -> AccountTVC? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "AccountTVC") as? AccountTVC
    }
    
    // MARK: - Outlets -
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var dateOfBirthTF: UITextField!
    @IBOutlet weak var avatarImg: UIImageView!
    
    // MARK: - Properties -
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // imgUser gesture
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        avatarImg?.isUserInteractionEnabled = true
        avatarImg?.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(handleScreenTapHideKeyboard(sender:)))
        self.view.addGestureRecognizer(tapGestureHideKeyboard)

    }
    
    @objc func handleScreenTapHideKeyboard(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        let ac = UIAlertController(title: "Выберите источник изображения", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Камера", style: .default) { [weak self] (_) in
            self?.chooseImagePickerAction(source: .camera)
        }
        let photoLibAction = UIAlertAction(title: "Галерея", style: .default) { [weak self] (_) in
            self?.chooseImagePickerAction(source: .photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        ac.addAction(cameraAction)
        ac.addAction(photoLibAction)
        ac.addAction(cancelAction)
        self.present(ac, animated: true, completion: nil)
    }
    
    // MARK: - Actions -
    func chooseImagePickerAction(source: UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

}
