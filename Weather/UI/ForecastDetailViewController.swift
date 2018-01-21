//
//  ForecastDetailViewController.swift
//  Weather
//
//  Created by Robert le Clus on 2018/01/20.
//  Copyright © 2018 Robert le Clus. All rights reserved.
//

import UIKit

private class IconModel {
    let icon: String
    let text: String
    let value: String
    init(icon: String, text: String, value: String) {
        self.icon = icon
        self.text = text
        self.value = value
    }
}

class ForecastDetailViewController: UIViewController {

    var forecast: DailyForecastData?

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var model: [IconModel] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        if let currentForecast = forecast {
            if currentForecast.icon != nil {
                weatherIcon.image = UIImage(named: forecast!.icon!)
            }
            let summary = NSMutableAttributedString()
            if currentForecast.time != nil {
                let font = UIFont.systemFont(ofSize: 15)
                summary.append(NSAttributedString(string: FormattingUtil.formatDate(date: currentForecast.time!), attributes: [NSAttributedStringKey.font : font]))
            }
            summary.append(NSAttributedString(string: "\n"))
            if currentForecast.summary != nil {
                let font = UIFont.systemFont(ofSize: 18)
                summary.append(NSAttributedString(string: currentForecast.summary!, attributes: [NSAttributedStringKey.font : font]))
            }
            summaryLabel.attributedText = summary
        }
        buildModel()
        collectionView.reloadData()
    }

    private func buildModel() {
        
        if let currentForecast = forecast {
            //temp high
            if currentForecast.temperatureHigh != nil {
                let temp = FormattingUtil.formatTemperature(temperature: currentForecast.temperatureHigh!)
                model.append(IconModel(icon: "temperatureHigh", text: "High", value: "\(temp) °C"))
            }
            //temp low
            if currentForecast.temperatureLow != nil {
                let temp = FormattingUtil.formatTemperature(temperature: currentForecast.temperatureLow!)
                model.append(IconModel(icon: "temperatureLow", text: "Low", value: "\(temp) °C"))
            }
            //windspeed
            if currentForecast.windSpeed != nil {
                model.append(IconModel(icon: "windspeed", text: "Wind Speed", value: "\(currentForecast.windSpeed!) m/s"))
            }
            //sunrise
            if currentForecast.sunriseTime != nil {
                model.append(IconModel(icon: "sunrise", text: "Sunrise", value: FormattingUtil.formatTime(date:currentForecast.sunriseTime!)))
            }
            //sunset
            if currentForecast.sunsetTime != nil {
                model.append(IconModel(icon: "sunset", text: "Sunset", value: FormattingUtil.formatTime(date:currentForecast.sunsetTime!)))
            }
            if currentForecast.windBearing != nil {
                let direction = FormattingUtil.formatDirection(degree: currentForecast.windBearing!)
                model.append(IconModel(icon: "winddirection", text: "Wind Direction", value: direction))
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ForecastDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return model.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = model[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastItemCollectionViewCell", for: indexPath) as! ForecastItemCollectionViewCell
        cell.iconView.image = UIImage(named: item.icon)
        cell.textLabel.text = item.text
        cell.valueLabel.text = item.value
        return cell
    }

}
