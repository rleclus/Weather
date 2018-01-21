//
//  TodayForecastTableViewCell.swift
//  Weather
//
//  Created by Robert le Clus on 2018/01/20.
//  Copyright © 2018 Robert le Clus. All rights reserved.
//

import UIKit

class TodayForecastTableViewCell: UITableViewCell, ForecastCellProtocol {
    
    @IBOutlet weak var weatherTemperature: UILabel!
    
    @IBOutlet weak var weatherDetails: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    private let mainFont = UIFont.systemFont(ofSize: 16)
    
    func updateWeatherDetails(details: DailyForecastData, currentTemperature: Double?) {
        
        if details.icon != nil {
            weatherIcon.image = UIImage(named:details.icon!)
        }
        let text = NSMutableAttributedString()
        addTimeline(details: details, to: text)
        addTemperature(details: details, to: text)
        weatherDetails.attributedText = text
        if currentTemperature != nil {
            let temperature = FormattingUtil.formatTemperature(temperature: currentTemperature!)
            weatherTemperature.text = "\(temperature) °C"
        } else {
            weatherTemperature.text = ""
        }
    }
    
    func addTimeline(details: DailyForecastData, to text: NSMutableAttributedString) {
        
        let date = FormattingUtil.formatDate(date: details.time ?? NSDate())
        let todayFont = UIFont.boldSystemFont(ofSize: 20)
        let dateFont = mainFont
        text.append(NSAttributedString(string: "Today ", attributes: [NSAttributedStringKey.font : todayFont]))
        text.append(NSAttributedString(string: "is \(date)", attributes: [NSAttributedStringKey.font : dateFont]))
    }
    
    func addTemperature(details: DailyForecastData, to text: NSMutableAttributedString) {
        if details.temperatureLow == nil || details.temperatureHigh == nil {
            return
        }
        let high = FormattingUtil.formatTemperature(temperature: details.temperatureHigh!)
        let low = FormattingUtil.formatTemperature(temperature: details.temperatureLow!)
        let tempMessage = "\nThe low for today is \(low) °C and the high is \(high) °C"
        text.append(NSAttributedString(string: tempMessage, attributes: [NSAttributedStringKey.font : mainFont]))
    }
    
}
