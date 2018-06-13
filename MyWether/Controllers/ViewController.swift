//
//  ViewController.swift
//  MyWether
//
//  Created by Vivek on 02/06/18.
//  Copyright © 2018 Vivek. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    // OUtlets
    @IBOutlet var cityName: UILabel!
    @IBOutlet var wetherType: UILabel!
    @IBOutlet var wetherImage: UIImageView!
    @IBOutlet var cityTemprature: UILabel!
    @IBOutlet var tomorrowWetherImage: UIImageView!
    @IBOutlet var TomorrowTemprature: UILabel!
    
    // variables
    
    var currentWether = CurrentWether()
    var locationManager = CLLocationManager()

    var currentLocation = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkFoLocationAuthorization()
        
    }
    
    fileprivate func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()// Requesting permission to the user
        locationManager.startMonitoringSignificantLocationChanges()
        
    }
    

    fileprivate func checkFoLocationAuthorization() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            // Get the cuurent location
          
            // strat location manger to get location
            locationManager.startUpdatingLocation()

        }else{
            locationManager.requestWhenInUseAuthorization()// Requesting permission to the user
            checkFoLocationAuthorization()// Check user has given permission or not
        }
    }
    
    fileprivate func downloadCurrentWetherData() {
        // Do any additional setup after loading the view, typically from a nib.
        currentWether.downloadCurrentWether(forLatitude: currentLocation.coordinate.latitude, andLongitude: currentLocation.coordinate.longitude, completed:{
            print("data downloaded")
            // Update the data on the user screen
            self.updateCurrentWetherOnScreen()
        })
    }
    
    fileprivate func updateCurrentWetherOnScreen() {
        self.cityName.text = currentWether.currentCity
        self.cityTemprature.text = "\(currentWether.currentTemp)"
        self.wetherType.text = currentWether.wetherType
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first!
                debugPrint("lat==>", currentLocation.coordinate.latitude)
        debugPrint("long==>", currentLocation.coordinate.longitude)
        // Pass current latitude & longitude
        Location.shared.lattitude = currentLocation.coordinate.latitude
        Location.shared.longitude = currentLocation.coordinate.longitude
        
        // Get the wether data
        downloadCurrentWetherData()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error.localizedDescription)
    }
}

