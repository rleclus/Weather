//
//  FormattingUtil.swift
//  Weather
//
//  Created by Robert le Clus on 2018/01/20.
//  Copyright © 2018 Robert le Clus. All rights reserved.
//

import UIKit

class FormattingUtil {
    
    static func formatTemperature(temperature: Double) -> String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumSignificantDigits = 2
        let stringTemp = numberFormatter.string(from: NSNumber(value: temperature))!
        return "\(stringTemp) °C"
    }
    
    static func formatDate(date: NSDate) -> String {
        
        let dateFormatter = DateFormatter(withFormat: "EEEE, MMM d, yyyy", locale: "en_ZA")
        return dateFormatter.string(from: date as Date)
    }
    
    static func formatTime(date: NSDate) -> String {

        let dateFormatter = DateFormatter(withFormat: "hh:MM:ss", locale: "en_ZA")
        return dateFormatter.string(from: date as Date)
    }
    
    static func formatDirection(degree: Double) -> String {
        
        let directions = ["N","NNE","NE","ENE","E","ESE", "SE", "SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"]
        var index = Int((degree / 22.5).rounded())
        index = index % directions.count
        return directions[index]
    }
 }
