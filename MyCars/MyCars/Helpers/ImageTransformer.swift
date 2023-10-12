//
//  ImageTransformer.swift
//  MyCars
//
//  Created by mac on 12.10.2023.
//  Copyright © 2023 Heorhii. All rights reserved.
//

import Foundation
import UIKit


class ImageTransformer: ValueTransformer {
    override func transformedValue(_ value: Any?) -> Any? {
        guard let image = value as? UIImage else { fatalError() }
        let imageData = image.pngData()
        return imageData
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { fatalError() }
        return UIImage(data: data)
    }
}
