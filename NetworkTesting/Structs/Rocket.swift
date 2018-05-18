//
//  FalconHeavy.swift
//  NetworkTesting
//
//  Created by Dave on 5/17/18.
//  Copyright © 2018 High Tree Development. All rights reserved.
//

import Foundation

struct Rocket: Codable {
    var id, name, type: String
    let active: Bool
    let stages, boosters, costPerLaunch, successRatePct: Int
    let firstFlight, country, company: String
    let height, diameter: Diameter
    let mass: Mass
    let payloadWeights: [PayloadWeight]
    let firstStage: FirstStage
    let secondStage: SecondStage
    let engines: Engines
    let landingLegs: LandingLegs
    let description: String

    enum CodingKeys: String, CodingKey {
        case id, name, type, active, stages, boosters
        case costPerLaunch = "cost_per_launch"
        case successRatePct = "success_rate_pct"
        case firstFlight = "first_flight"
        case country, company, height, diameter, mass
        case payloadWeights = "payload_weights"
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case engines
        case landingLegs = "landing_legs"
        case description
    }
}
