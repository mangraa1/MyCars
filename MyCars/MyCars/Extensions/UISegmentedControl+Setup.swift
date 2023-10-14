//
//  UISegmentedControl+Setup.swift
//  MyCars
//
//  Created by mac on 14.10.2023.
//  Copyright © 2023 Heorhii. All rights reserved.
//

import UIKit


extension UISegmentedControl {
    func setupAttributes() {
        let whiteTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let blackTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        UISegmentedControl.appearance().setTitleTextAttributes(whiteTitleTextAttributes, for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes(blackTitleTextAttributes, for: .selected)
    }
}
