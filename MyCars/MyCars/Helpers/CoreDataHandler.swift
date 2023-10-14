//
//  CoreDataHandler.swift
//  MyCars
//
//  Created by mac on 12.10.2023.
//  Copyright © 2023 Heorhii. All rights reserved.
//

import UIKit
import CoreData


class CoreDataHandler {
    static func insertDataFor(car: Car, into viewController: ViewController) {
        viewController.carImageView.image = UIImage(data: car.imageData!)
        viewController.markLabel.text = car.mark
        viewController.modelLabel.text = car.model
        viewController.myChoiceImageView.isHidden = !car.myChoice
        viewController.segmentedControl.backgroundColor = car.tintColor as? UIColor

        if let lastStarted = car.lastStarted {
            viewController.lastTimeStartedLabel.text = "Last time started: \(DateFormatterHelper.shared.string(from: lastStarted))"
        }

        viewController.numberOfTripsLabel.text = "Number of trips: \(car.timesDriven)"
        viewController.ratingLabel.text = "Rating: \(car.rating) / 10"
    }
}
