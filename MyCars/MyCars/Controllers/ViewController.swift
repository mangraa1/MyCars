//
//  ViewController.swift
//  MyCars
//
//  Created by mac on 11.10.2023.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    //MARK:  @IBOutlets & Variables

    public var context: NSManagedObjectContext!

    private var selectedCar: Car!

    @IBOutlet weak var segmentedControl: UISegmentedControl! {
        didSet {
            DataMananger.loadDataForSelectedCar(context: context, into: self) { car in
                selectedCar = car
            }
            segmentedControl.selectedSegmentTintColor = .white
            segmentedControl.setupAttributes()
        }
    }
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var lastTimeStartedLabel: UILabel!
    @IBOutlet weak var numberOfTripsLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var myChoiceImageView: UIImageView!

    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        DataMananger.loadInitialDataIfNeeded(context: context)
    }

    //MARK: - @IBActions

    @IBAction func segmentedCtrlPressed(_ sender: UISegmentedControl) {
        DataMananger.loadDataForSelectedCar(context: context, into: self) { car in
            selectedCar = car
        }
    }
    
    @IBAction func startEnginePressed(_ sender: UIButton) {
        DataMananger.updateTimesDriven(selectedCar, into: self)
    }
    
    @IBAction func rateItPressed(_ sender: UIButton) {
        DataMananger.updateRatingForSelectedCar(selectedCar, into: self)
    }
}
