//
//  PasswordRepairVC.swift
//  krugozor-visitorsApp
//
//  Created by Stanly Shiyanovskiy on 28.09.17.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import UIKit

class PasswordRepairVC: UIViewController {

    static func storyboardInstance() -> PasswordRepairVC? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "PasswordRepairVC") as? PasswordRepairVC
    }

    // MARK: - Properties -
    @IBOutlet weak var emailTF: UITextField! {
        didSet {
            emailTF.useUnderline()
        }
    }

    // MARK: - Outlets -

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Actions -
    @IBAction func resetPswdBtn(_ sender: UIButton) {
        print("resetPswd")
    }

    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
