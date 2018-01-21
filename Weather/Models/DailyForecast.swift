//
//  DailyForecast.swift
//  Weather
//
//  Created by Robert le Clus on 2018/01/20.
//  Copyright © 2018 Robert le Clus. All rights reserved.
//

import ObjectMapper

class DailyForecast: Mappable {
    
    var summary: String?
    var icon: String?
    var data: [DailyForecastData]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        summary <- map["summary"]
        icon <- map["icon"]
        data <- map["data"]
    }
    
    
}
