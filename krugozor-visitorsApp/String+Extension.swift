//
//  String+Extension.swift
//  krugozor-visitorsApp
//
//  Created by Stanly Shiyanovskiy on 28.09.17.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation

extension String {

    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    func phoneNumberValidate(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }

    mutating func checkPhoneNumberFormat() -> String {

        if self.count == 6 {
            self = "+7 (\(self))"
        }

        return self
    }
    
    func checkPhoneNumber(_ textFieldString: String, in range: NSRange, replacement string: String) -> (Bool, String) {
        
        let temp = "+7"
        
        let validationSet = NSCharacterSet.decimalDigits.inverted
        let components = string.components(separatedBy: validationSet)
        
        guard components.count == 1 else { return (false, temp) }
        
        guard var newString = (textFieldString as NSString?)?.replacingCharacters(in: range, with: string) else { return (false, temp) }
        
        let validComponents = newString.components(separatedBy: validationSet)
        newString = validComponents.joined(separator: "")
        
        let areaMaxLength = 4
        let numberMaxLength = 7
        
        if newString.count > (areaMaxLength + numberMaxLength + 7) {
            return (false, temp)
        }
        
        var resultString = ""
        let areaLength = min(newString.count, areaMaxLength)
        
        if areaLength > 0 {
            let start = newString.index(newString.startIndex, offsetBy: 1)
            let end = newString.index(newString.startIndex, offsetBy: areaLength)
            resultString = "\(newString[start..<end])"
            
        }
        
        if newString.count > areaLength {
            let numberLength = min((newString.count - areaMaxLength), numberMaxLength)
            
            let start = newString.index(newString.startIndex, offsetBy: areaLength)
            let end = newString.index(newString.startIndex, offsetBy: areaLength + numberLength)
            let number = "\(newString[start..<end])"
            
            resultString = "\(resultString)\(number)"
        }
        
        resultString.insert(contentsOf: "+7", at: String.Index.init(encodedOffset: 0))
        
        if newString.count > 1 {
            resultString.insert(contentsOf: " (", at: String.Index.init(encodedOffset: 2))
            if newString.count > 4 {
                resultString.insert(contentsOf: ") ", at: String.Index.init(encodedOffset: 7))
                if newString.count > 7 {
                    resultString.insert("-", at: String.Index.init(encodedOffset: 12))
                    if newString.count > 9 {
                        resultString.insert("-", at: String.Index.init(encodedOffset: 15))
                    }
                }
            }
        }
        
        return (false, resultString)
    }
}
