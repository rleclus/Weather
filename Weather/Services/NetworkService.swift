//
//  NetworkService.swift
//  Weather
//
//  Created by Robert le Clus on 2018/01/20.
//  Copyright © 2018 Robert le Clus. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import AlamofireObjectMapper

class NetworkService: NSObject {
    static let shared = NetworkService()
    private let apiKey = "f4c4c6b069fcfc8a04a606ecae24f6ca"
    private let baseURL = "https://api.darksky.net/forecast"
    private let parameters = "?units=si&exclude=minutely,hourly,flags"
    private override init() {
        
    }
    
    private func generateRequest(location: CLLocationCoordinate2D) -> URLRequest {
        
        let urlString = "\(baseURL)/\(apiKey)/\(location.latitude),\(location.longitude)\(parameters)"
        let url = URL(string: urlString)
        return URLRequest(url: url!)
    }
    
    func getForecast(location: CLLocationCoordinate2D, completion: @escaping ((_ forecast: Forecast?, _ error: Error?) -> ())) {
        Alamofire.request(generateRequest(location: location)).responseObject { (response: DataResponse<Forecast>) in
            if response.result.isFailure {
                completion(nil,response.result.error)
            } else {
                completion(response.result.value, nil)
            }
        }
    }
    
}
