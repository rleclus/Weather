//
//  ForecastTableViewCell.swift
//  Weather
//
//  Created by Robert le Clus on 2018/01/20.
//  Copyright © 2018 Robert le Clus. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell, ForecastCellProtocol {

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView?.tintColor = UIColor.black
    }
    
    func updateWeatherDetails(details: DailyForecastData, currentTemperature: Double?) {

        textLabel?.numberOfLines = 0
        let high = FormattingUtil.formatTemperature(temperature: details.temperatureHigh!)
        textLabel?.text = "\(high) - \(details.summary!)"
        imageView?.image = UIImage(named: details.icon!)
        detailTextLabel?.text = FormattingUtil.formatDate(date: details.time!)

    }

}
