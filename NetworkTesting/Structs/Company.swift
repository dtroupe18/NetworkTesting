//
//  Company.swift
//  NetworkTesting
//
//  Created by Dave on 5/17/18.
//  Copyright © 2018 High Tree Development. All rights reserved.
//

import Foundation

// To parse the JSON, add this file to your project and do:
//
//   let empty = try? JSONDecoder().decode(Empty.self, from: jsonData)

import Foundation

struct Company: Codable {
    let name, founder: String
    let founded, employees, vehicles, launchSites: Int
    let testSites: Int
    let ceo, cto, coo, ctoPropulsion: String
    let valuation: Int
    let headquarters: Headquarters
    let summary: String
    
    enum CodingKeys: String, CodingKey {
        case name, founder, founded, employees, vehicles
        case launchSites = "launch_sites"
        case testSites = "test_sites"
        case ceo, cto, coo
        case ctoPropulsion = "cto_propulsion"
        case valuation, headquarters, summary
    }
}

