//
//  Globals.swift
//  MyWether
//
//  Created by Vivek on 03/06/18.
//  Copyright © 2018 Vivek. All rights reserved.
//

import Foundation

// API url for wether

let API_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.shared.lattitude!)&lon=\(Location.shared.longitude!)&appid=29d04cec6cf08585cb7ec653441035d7"

typealias DownloadComplete = () -> ()
