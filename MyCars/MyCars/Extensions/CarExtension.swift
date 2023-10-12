//
//  CarExtension.swift
//  MyCars
//
//  Created by mac on 11.10.2023.
//  Copyright © 2023 Heorhii. All rights reserved.
//

import CoreData
import UIKit


extension Car {
    static func createCar(from dictionary: [String: AnyObject], in context: NSManagedObjectContext) -> Car? {
        let entity = NSEntityDescription.entity(forEntityName: "Car", in: context)
        let car = NSManagedObject(entity: entity!, insertInto: context) as? Car

        // Initializing Attributes
        car?.mark = dictionary["mark"] as? String
        car?.model = dictionary["model"] as? String
        car?.myChoice = dictionary["myChoice"] as? Bool ?? false
        car?.rating = dictionary["rating"] as? Float ?? 0.0
        car?.timesDriven = dictionary["timesDriven"] as? Int16 ?? 0
        car?.lastStarted = dictionary["lastStarted"] as? Date

        let imageName = dictionary["imageName"] as? String
        let carImage = UIImage(named: imageName!)
        let imageData = carImage?.pngData()
        car?.imageData = imageData

        if let colorDictionary = dictionary["tintColor"] as? [String: Float] {
            car?.tintColor = getColor(colorDictionary: colorDictionary)
        }

        return car
    }

    static func saveCarToCoreData(_ car: Car?, context: NSManagedObjectContext) {
        if let _ = car {
            do {
                try context.save()
            } catch let error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    private static func getColor(colorDictionary: [String: Float]) -> UIColor {
        guard let red = colorDictionary["red"],
              let green = colorDictionary["green"],
              let blue = colorDictionary["blue"] else { return UIColor() }

        return UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1.0)
    }
}
