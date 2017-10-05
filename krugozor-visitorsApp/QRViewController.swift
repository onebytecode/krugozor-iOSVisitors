//
//  QRViewController.swift
//  krugozor-visitorsApp
//
//  Created by Анатолий on 04.10.2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import UIKit
import QRCode

class QRViewController: UIViewController {

    @IBOutlet weak var qrCodeImage: UIImageView!

    override func viewDidLoad() {
        showQRCode ()
    }

    fileprivate func showQRCode () {
        qrCodeImage.image = {
            var qrCode = QRCode("anatoly@mail.ru")!
            qrCode.size = self.qrCodeImage.bounds.size
            qrCode.errorCorrection = .High
            return qrCode.image
        }()
    }
}
