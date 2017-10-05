//
//  TabBarViewController.swift
//  krugozor-visitorsApp
//
//  Created by Анатолий on 04.10.2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    static func storyboardInstance() -> TabBarViewController? {
        return UIStoryboard.init(name: String(describing: self), bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
    }
}
