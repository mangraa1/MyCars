//
//  CarExtension.swift
//  MyCars
//
//  Created by mac on 11.10.2023.
//  Copyright © 2023 Heorhii. All rights reserved.
//

import Foundation
import CoreData


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
}
