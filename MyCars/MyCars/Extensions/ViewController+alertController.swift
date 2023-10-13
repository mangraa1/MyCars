//
//  ViewController+alertController.swift
//  MyCars
//
//  Created by mac on 13.10.2023.
//  Copyright © 2023 Heorhii. All rights reserved.
//

import UIKit


extension ViewController {
    func updateRateAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, completion: @escaping (_ rate: Float) -> ()) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)

        let rateAction = UIAlertAction(title: "Rate", style: .default) { action in
            if let text = ac.textFields?.first?.text {
                let rate = (text as NSString).floatValue
                completion(rate)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)

        ac.addTextField { tf in
            tf.keyboardType = .numberPad
        }

        [cancelAction, rateAction].forEach { ac.addAction($0) }
        present(ac, animated: true)
    }

    func warningAlert(withTitle title: String?, message: String?, style: UIAlertController.Style) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "Ok", style: .default)

        ac.addAction(okAction)
        present(ac, animated: true)
    }
}
