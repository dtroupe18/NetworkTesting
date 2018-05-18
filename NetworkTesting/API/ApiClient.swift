//
//  NativeApiClient.swift
//  NetworkTesting
//
//  Created by Dave on 5/17/18.
//  Copyright © 2018 High Tree Development. All rights reserved.
//

import Foundation

class ApiClient: SpaceXApiClient {
    
    static func getRocketInfo(rocketName name: String, onSuccess: RocketCallback? = nil, onError: ErrorCallback? = nil) {
        
        let urlString: String = "https://api.spacexdata.com/v2/rockets/\(name)"
        guard let url: URL = URL(string: urlString) else {
            let urlError: Error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Error URL is not working!"]) as Error
            onError?(urlError)
            return
        }
        
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = defaultSession.dataTask(with: url, completionHandler: { data, response, error in
            
            if let error = error {
                onError?(error)
            } else if let data = data {
                // Use Codable to decode the rocket information
                let decoder = JSONDecoder()
                do {
                    let rocket = try decoder.decode(Rocket.self, from: data)
                    onSuccess?(rocket)
                } catch {
                    let dataError: Error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Error data incorrectly formatted"]) as Error
                    onError?(dataError)
                }
                
            }
        })
        dataTask.resume()
    }
    
    static func getCompanyInfo(onSuccess: CompanyCallback? = nil, onError: ErrorCallback? = nil) {
        
        let urlString: String = "https://api.spacexdata.com/v2/info"
        guard let url: URL = URL(string: urlString) else {
            let urlError: Error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Error URL is not working!"]) as Error
            onError?(urlError)
            return
        }
        
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = defaultSession.dataTask(with: url, completionHandler: { data, response, error in
            
            if let error = error {
                onError?(error)
            } else if let data = data {
                // Use Codable to decode the company information
                let decoder = JSONDecoder()
                do {
                    let company = try decoder.decode(Company.self, from: data)
                    onSuccess?(company)
                } catch {
                    let dataError: Error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Error data incorrectly formatted"]) as Error
                    onError?(dataError)
                }
                
            }
        })
        dataTask.resume()
    }
}
