//
//  UITextField+Extension.swift
//  krugozor-visitorsApp
//
//  Created by Stanly Shiyanovskiy on 28.09.17.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func useUnderline() {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.CustomColors.dividerBlue.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func addPoleForButtonsToKeyboard(myAction:Selector?, buttonNeeds: Bool) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        doneToolbar.backgroundColor = .white
        doneToolbar.sizeToFit()
        self.inputAccessoryView = doneToolbar
        
        if buttonNeeds {
            let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Return", style: UIBarButtonItemStyle.done, target: self, action: myAction)
            done.tintColor = UIColor.CustomColors.dividerBlue
            
            var items = [UIBarButtonItem]()
            items.append(flexSpace)
            items.append(done)
            
            doneToolbar.items = items
        }
    }
}
