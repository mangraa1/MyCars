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

    @IBOutlet weak var segmentedControl: UISegmentedControl!
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
        DataMananger.loadDataForSelectedCar(context: context, into: self)
    }

    //MARK: - @IBActions

    @IBAction func segmentedCtrlPressed(_ sender: UISegmentedControl) {}
    
    @IBAction func startEnginePressed(_ sender: UIButton) {}
    
    @IBAction func rateItPressed(_ sender: UIButton) {}
}

