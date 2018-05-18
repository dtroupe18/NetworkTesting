//
//  FirstStage.swift
//  NetworkTesting
//
//  Created by Dave on 5/17/18.
//  Copyright © 2018 High Tree Development. All rights reserved.
//

import Foundation

struct FirstStage: Codable {
    let reusable: Bool
    let engines, fuelAmountTons, cores, burnTimeSEC: Int
    let thrustSeaLevel, thrustVacuum: Thrust
    
    enum CodingKeys: String, CodingKey {
        case reusable, engines
        case fuelAmountTons = "fuel_amount_tons"
        case cores
        case burnTimeSEC = "burn_time_sec"
        case thrustSeaLevel = "thrust_sea_level"
        case thrustVacuum = "thrust_vacuum"
    }
}

