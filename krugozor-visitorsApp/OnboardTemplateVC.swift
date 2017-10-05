//
//  OnboardTemplateVC.swift
//  krugozor-visitorsApp
//
//  Created by Stanly Shiyanovskiy on 27.09.17.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import UIKit

class OnboardTemplateVC: UIViewController {

    static func storyboardInstance() -> OnboardTemplateVC? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "OnboardTemplateVC") as? OnboardTemplateVC
    }

    // MARK: - Properties -
    var itemIndex: Int = 0
    var contentModel: (String, String) = ("", "") {
        didSet {
            if let label = contentLabel {
                label.text = contentModel.1
            }
        }
    }

    // MARK: - Outlets -
    @IBOutlet var contentLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        contentLabel?.text = contentModel.1
    }
}
