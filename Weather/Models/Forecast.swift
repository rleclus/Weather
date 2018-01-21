//
//  Forecast.swift
//  Weather
//
//  Created by Robert le Clus on 2018/01/20.
//  Copyright © 2018 Robert le Clus. All rights reserved.
//

import ObjectMapper

class Forecast: Mappable {

    var latitude: Double?
    var longitude: Double?
    var currentForecast: DailyForecastData?
    var dailyForecast: DailyForecast?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        longitude <- map["longitude"]
        latitude <- map["latitude"]
        currentForecast <- map["currently"]
        dailyForecast <- map["daily"]
    }

}
