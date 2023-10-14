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

    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyCars")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - CRUD

    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

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

    static func loadDataForSelectedCar(context: NSManagedObjectContext, into viewController: ViewController, completion: (_ car: Car) -> ()) {
        
        let fetchRequest = Car.fetchRequest()
        let mark = viewController.segmentedControl.titleForSegment(at: viewController.segmentedControl.selectedSegmentIndex)
        fetchRequest.predicate = NSPredicate(format: "mark == %@", mark!)

        do {
            let results = try context.fetch(fetchRequest)
            let car = results.first
            CoreDataHandler.insertDataFor(car: car!, into: viewController)
            completion(car!)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    static func updateTimesDriven(_ car: Car, into viewController: ViewController) {
        car.timesDriven += 1
        car.lastStarted = Date()

        DataMananger.saveContext()
        CoreDataHandler.insertDataFor(car: car, into: viewController)
    }

    static func updateRatingForSelectedCar(_ car: Car, into viewController: ViewController) {
        viewController.updateRateAlertController(withTitle: "Rate", message: "Rate this car", style: .alert) { rate in
            car.rating = rate

            do {
                try self.persistentContainer.viewContext.save()
                CoreDataHandler.insertDataFor(car: car, into: viewController)
            } catch let error {
                viewController.warningAlertController(withTitle: "Wrong value", message: "Wrong input", style: .alert)
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
