//
//  DailyForecastData.swift
//  Weather
//
//  Created by Robert le Clus on 2018/01/20.
//  Copyright © 2018 Robert le Clus. All rights reserved.
//

import ObjectMapper

class MilisecondDateTransform: TransformType {

    typealias Object = NSDate
    typealias JSON = Double
    
    init() {}
    func transformFromJSON(_ value: Any?) -> NSDate? {
        if let timeDouble = value as? Double {
            return NSDate(timeIntervalSince1970: TimeInterval(timeDouble))
        }
        return nil
    }
    
    func transformToJSON(_ value: NSDate?) -> Double? {
        
        if let date = value {
            return Double(date.timeIntervalSince1970)
        }
        return nil
    }
}

class DailyForecastData: Mappable {
    
    var time: NSDate?
    var summary: String?
    var icon: String? // "partly-cloudy-day"
    var sunriseTime: NSDate? // 1517066334,
    var sunsetTime: NSDate? //1517102906,
    var moonPhase: Double? //0.36,
    var precipIntensity: Int? //0,
    var precipIntensityMax: Double? //0.0002,
    var precipIntensityMaxTime: NSDate? //1517101200,
    var precipProbability: Int? //0,
    var temperature: Double?
    var temperatureHigh: Double? //57.55,
    var temperatureHighTime: NSDate? //1517094000,
    var temperatureLow: Double? //47.73,
    var temperatureLowTime: NSDate? //1517155200,
    var apparentTemperatureHigh: Double? //57.55,
    var apparentTemperatureHighTime: NSDate? //1517094000,
    var apparentTemperatureLow: Double? //45.22,
    var apparentTemperatureLowTime: NSDate? //1517155200,
    var dewPoint: Double? //38.78,
    var humidity: Double? //0.66,
    var pressure: Double? //1029.85,
    var windSpeed: Double? //2.78,
    var windGust: Double? //8.71,
    var windGustTime: NSDate? //1517040000,
    var windBearing: Double? //5,
    var cloudCover: Double? //0.4,
    var uvIndex: Int64? //2,
    var uvIndexTime: NSDate? //1517079600,
    var ozone: Double? //324.11,
    var temperatureMin: Double? //45.15,
    var temperatureMinTime: NSDate? //1517061600,
    var temperatureMax: Double? //57.55,
    var temperatureMaxTime: NSDate? //1517094000,
    var apparentTemperatureMin: Double? //42.17,
    var apparentTemperatureMinTime: NSDate? //1517043600,
    var apparentTemperatureMax: Double? //57.55,
    var apparentTemperatureMaxTime: NSDate? //1517094000
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        time <- (map["time"], MilisecondDateTransform())  //1517040000,
        summary <- map["summary"] //"Partly cloudy until evening.",
        icon <- map["icon"] //"partly-cloudy-day",
        sunriseTime <- (map["sunriseTime"], MilisecondDateTransform()) //1517066334,
        sunsetTime <- (map["sunsetTime"], MilisecondDateTransform()) //1517102906,
        moonPhase <- map["moonPhase"] //0.36,
        precipIntensity <- map["precipIntensity"] //0,
        precipIntensityMax <- map["precipIntensityMax"] //0.0002,
        precipIntensityMaxTime <- (map["precipIntensityMaxTime"], MilisecondDateTransform()) //1517101200,
        precipProbability <- map["precipProbability"] //0,
        temperature <- map["temperature"] //57.55,
        temperatureHigh <- map["temperatureHigh"] //57.55,
        temperatureHighTime <- (map["temperatureHighTime"], MilisecondDateTransform()) //1517094000,
        temperatureLow <- map["temperatureLow"] //47.73,
        temperatureLowTime <- (map["temperatureLowTime"], MilisecondDateTransform()) //1517155200,
        apparentTemperatureHigh <- map["apparentTemperatureHigh"] //57.55,
        apparentTemperatureHighTime <- (map["apparentTemperatureHighTime"], MilisecondDateTransform()) //1517094000,
        apparentTemperatureLow <- map["apparentTemperatureLow"] //45.22,
        apparentTemperatureLowTime <- (map["apparentTemperatureLowTime"], MilisecondDateTransform()) //1517155200,
        dewPoint <- map["dewPoint"] //38.78,
        humidity <- map["humidity"] //0.66,
        pressure <- map["pressure"] //1029.85,
        windSpeed <- map["windSpeed"] //2.78,
        windGust <- map["windGust"] //8.71,
        windGustTime <- (map["windGustTime"], MilisecondDateTransform()) //1517040000,
        windBearing <- map["windBearing"] //5,
        cloudCover <- map["cloudCover"] //0.4,
        uvIndex <- map["uvIndex"] //2,
        uvIndexTime <- (map["uvIndexTime"], MilisecondDateTransform()) //1517079600,
        ozone <- map["ozone"] //324.11,
        temperatureMin <- map["temperatureMin"] //45.15,
        temperatureMinTime <- (map["temperatureMinTime"], MilisecondDateTransform()) //1517061600,
        temperatureMax <- map["temperatureMax"] //57.55,
        temperatureMaxTime <- (map["temperatureMaxTime"], MilisecondDateTransform()) //1517094000,
        apparentTemperatureMin <- map["apparentTemperatureMin"] //42.17,
        apparentTemperatureMinTime <- (map["apparentTemperatureMinTime"], MilisecondDateTransform()) //1517043600,
        apparentTemperatureMax <- map["apparentTemperatureMax"] //57.55,
        apparentTemperatureMaxTime <- (map["apparentTemperatureMaxTime"], MilisecondDateTransform()) //1517094000
    }
    

}
