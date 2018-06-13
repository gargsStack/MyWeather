//
//  CurrentWether.swift
//  MyWether
//
//  Created by Vivek on 03/06/18.
//  Copyright © 2018 Vivek. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWether {
    
    
    private var _currentCity: String!
    private var _currentTemp: Double!
    private var _wetherType: String!
    
    var currentCity: String {
        if _currentCity == nil {
            _currentCity = ""
        }
        return _currentCity
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    var wetherType: String {
        if _wetherType == nil {
            _wetherType = ""
        }
        return _wetherType
    }
    
    func downloadCurrentWether(forLatitude lat:Double,andLongitude long:Double, completed: @escaping DownloadComplete) {

        let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=29d04cec6cf08585cb7ec653441035d7"
        Alamofire.request(url).responseJSON(completionHandler: {(response) in
            
            debugPrint(response)
            if let error = response.result.error {
                debugPrint(error.localizedDescription)
                return
            }else if let result = response.result.value as? [String:Any]{
                debugPrint(result)
                if let city = result["name"] as? String {
                self._currentCity = city
                }
                if let wethers = result["weather"] as? [[String:Any]], let wetherType = wethers.first!["main"] as? String {
                    self._wetherType = wetherType
                }
                if let mainData = result["main"] as? [String:Any], let temp = mainData["temp"] as? NSNumber {
                    self._currentTemp = temp.doubleValue.rounded() - 273.15
                }
            }
            completed()
        })
    }
}









