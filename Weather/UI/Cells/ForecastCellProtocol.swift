//
//  ForecastCellProtocol.swift
//  Weather
//
//  Created by Robert le Clus on 2018/01/20.
//  Copyright © 2018 Robert le Clus. All rights reserved.
//

protocol ForecastCellProtocol {
    func updateWeatherDetails(details: DailyForecastData, currentTemperature: Double?)
}
