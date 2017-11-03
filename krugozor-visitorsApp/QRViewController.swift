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
    
    var model: QRModelProtocol!
    
    @IBOutlet weak var qrCodeImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        buildingDependencies ()
        showQRCode ()
    }
    
    /// Establishing links between abstract class
    private func buildingDependencies () {
        model = QRModel()
        //model.userModule = UserModule()
    }

    /// Create and encrypt QR code
    fileprivate func showQRCode () {
        let uid = model.getUID()
        guard uid != "" else { return } // Удалить строку если не видно QR кода
        qrCodeImage.image = {
            var qrCode = QRCode(uid)!
            qrCode.size = self.qrCodeImage.bounds.size
            qrCode.errorCorrection = .High
            return qrCode.image
        }()
    }
}












