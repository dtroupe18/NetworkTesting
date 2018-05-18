//
//  Engines.swift
//  NetworkTesting
//
//  Created by Dave on 5/17/18.
//  Copyright © 2018 High Tree Development. All rights reserved.
//

import Foundation

struct Engines: Codable {
    let number: Int
    let type, version, layout: String
    let engineLossMax: Int
    let propellant1, propellant2: String
    let thrustSeaLevel, thrustVacuum: Thrust
    let thrustToWeight: Double
    
    enum CodingKeys: String, CodingKey {
        case number, type, version, layout
        case engineLossMax = "engine_loss_max"
        case propellant1 = "propellant_1"
        case propellant2 = "propellant_2"
        case thrustSeaLevel = "thrust_sea_level"
        case thrustVacuum = "thrust_vacuum"
        case thrustToWeight = "thrust_to_weight"
    }
}
