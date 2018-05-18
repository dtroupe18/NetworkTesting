//
//  Payloads.swift
//  NetworkTesting
//
//  Created by Dave on 5/17/18.
//  Copyright © 2018 High Tree Development. All rights reserved.
//

import Foundation

struct Payloads: Codable {
    let option1, option2: String
    let compositeFairing: CompositeFairing
    
    enum CodingKeys: String, CodingKey {
        case option1 = "option_1"
        case option2 = "option_2"
        case compositeFairing = "composite_fairing"
    }
}
