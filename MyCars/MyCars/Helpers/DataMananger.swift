//
//  CoreDataMaanger.swift
//  MyCars
//
//  Created by mac on 11.10.2023.
//  Copyright © 2023 Heorhii. All rights reserved.
//

import Foundation
import CoreData


fileprivate enum UserDefaultsKeys {
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

    static func loadDataForSelectedCar(context: NSManagedObjectContext, into viewController: ViewController) {
        let fetchRequest = Car.fetchRequest()
        let mark = viewController.segmentedControl.titleForSegment(at: 0)
        fetchRequest.predicate = NSPredicate(format: "mark == %@", mark!)

        do {
            let results = try context.fetch(fetchRequest)
            let car = results.first!
            CoreDataHandler.insertDataFor(car: car, into: viewController)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
