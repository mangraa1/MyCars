//
//  DateFormatterHelper.swift
//  MyCars
//
//  Created by mac on 12.10.2023.
//  Copyright © 2023 Heorhii. All rights reserved.
//

import Foundation


class DateFormatterHelper {
    static let shared: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .none
        return df
    }()

    private init() {}
}
