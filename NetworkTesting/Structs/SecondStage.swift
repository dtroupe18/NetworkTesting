//
//  SecondStage.swift
//  NetworkTesting
//
//  Created by Dave on 5/17/18.
//  Copyright © 2018 High Tree Development. All rights reserved.
//

import Foundation

struct SecondStage: Codable {
    let engines, burnTimeSEC: Int
    let thrust: Thrust
    let payloads: Payloads
    
    enum CodingKeys: String, CodingKey {
        case engines
        case burnTimeSEC = "burn_time_sec"
        case thrust, payloads
    }
}
