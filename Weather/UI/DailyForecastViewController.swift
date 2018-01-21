//
//  ViewController.swift
//  Weather
//
//  Created by Robert le Clus on 2018/01/20.
//  Copyright © 2018 Robert le Clus. All rights reserved.
//

import UIKit
import CoreLocation

class DailyForecastViewController: UIViewController {

    var forecast: Forecast?
    var dailyForecasts: [DailyForecastData]?
    @IBOutlet var tableView: UITableView!
    let defaultCoordinates = CLLocationCoordinate2D(latitude: -33.922703, longitude: 18.418949)
    var coordinates: CLLocationCoordinate2D?
    private let locationManager = CLLocationManager()
    
    private var defaultAlert: UIAlertController? = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        showLoadingView()
        coordinates = defaultCoordinates
    }
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        getCurrentLocation()
    }
    
    func getCurrentLocation() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .restricted, .denied:
            getDefaultForecasts()
            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            // Enable location features
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.distanceFilter = 100.0  // In meters.
            locationManager.startUpdatingLocation()
            break
        }
    }
    
    private func showLoadingView() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let waiting = storyboard.instantiateViewController(withIdentifier: "WaitingView")
        view.addSubview(waiting.view)
    
    }
    
    private func removeLoadingView() {
        view.viewWithTag(999)?.removeFromSuperview()
    }
    
    private func getDefaultForecasts() {
        if defaultAlert == nil {
            defaultAlert = UIAlertController(title: "Oops", message: "Sorry. We can't access your location at this time. Loading weather for Cape Town, South Africa", preferredStyle: .alert)
            defaultAlert!.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action) in
                self?.getForecasts()
            }))
            self.present(defaultAlert!, animated: true, completion: nil)
        } else {
            self.getForecasts()
        }
    }
    
    func getForecasts() {
        
        NetworkService.shared.getForecast(location: coordinates!) { [weak self] (forecast, error) in
            
            if forecast == nil {
                DispatchQueue.main.async(execute: {
                    self?.showError(message: error?.localizedDescription ?? "")
                })
            } else {
                self?.forecast = forecast
                self?.dailyForecasts = forecast?.dailyForecast?.data
                DispatchQueue.main.async(execute: {
                    self?.tableView.reloadData()
                    self?.removeLoadingView()
                })
            }
            
        }
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Oops", message: "Sorry, but we cannot get any forecasts at this time. \n\(message)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reload", style: .default, handler: { [weak self] (action) in
            self?.getForecasts()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let path = self.tableView.indexPathForSelectedRow
        if path != nil {
            let detailController = segue.destination as! ForecastDetailViewController
            detailController.forecast = self.dailyForecasts?[path!.row]
        }
    }

    @IBAction func infoButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "About", message: "Created by Robert le Clus ©2018\n\n Powered by Dark Sky", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "DarkSky.net", style: .default, handler: { (action) in
            UIApplication.shared.open(URL(string:"https://darksky.net/poweredby/")!, options: [:], completionHandler: nil)
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension DailyForecastViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dailyForecasts != nil {
            return (dailyForecasts?.count ?? 0)
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let row = indexPath.row
        let dailyForecast = dailyForecasts![row]
        let identifier = indexPath.row == 0 ? "TodayForecastCell" : "ForecastCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)! as! ForecastCellProtocol
        
        cell.updateWeatherDetails(details: dailyForecast, currentTemperature: forecast?.currentForecast?.temperature)
        return cell as! UITableViewCell
    }
}

extension DailyForecastViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        coordinates = (location?.coordinate)!
        locationManager.stopUpdatingLocation()
        getForecasts()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        coordinates = defaultCoordinates
        getForecasts()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            getForecasts()
        }
    }
    
}
