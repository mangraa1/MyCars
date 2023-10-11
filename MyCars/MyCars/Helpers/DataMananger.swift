//
//  CoreDataMaanger.swift
//  MyCars
//
//  Created by mac on 11.10.2023.
//  Copyright © 2023 Heorhii. All rights reserved.
//

import Foundation
import CoreData


 enum UserDefaultsKeys {
    static let dataLoaded = "dataLoaded"
}

class DataMananger {
    static func loadInitialDataIfNeeded(context: NSManagedObjectContext) {
        if !UserDefaults.standard.bool(forKey: UserDefaultsKeys.dataLoaded) {
            guard let pathToFile = Bundle.main.path(forResource: "data", ofType: "plist"),
                  let dataArray = NSArray(contentsOfFile: pathToFile) else { return }

            for dictionary in dataArray {
                if let carDictionary = dictionary as? [String: AnyObject] {
                    let car = Car.createCar(from: carDictionary, in: context)
                    Car.saveCarToCoreData(car, context: context)
                }
            }
            UserDefaults.standard.set(true, forKey: UserDefaultsKeys.dataLoaded)
        }
    }
}
