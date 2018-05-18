//
//  SpaceXapi.swift
//  NetworkTesting
//
//  Created by Dave on 5/17/18.
//  Copyright © 2018 High Tree Development. All rights reserved.
//

import Foundation

protocol SpaceXApiClient {
    
    typealias RocketCallback = (Rocket) -> Void
    typealias CompanyCallback = (Company) -> Void
    typealias ErrorCallback = (Error) -> Void
    
    static func getRocketInfo(rocketName: String, onSuccess: RocketCallback?, onError: ErrorCallback?)
    
    static func getCompanyInfo(onSuccess: CompanyCallback?, onError: ErrorCallback?)
}


/*
 
 // Docs: https://github.com/r-spacex/SpaceX-API/wiki
 
 // Rocket Info
 GET https://api.spacexdata.com/v2/rockets/falcon1
 GET https://api.spacexdata.com/v2/rockets/falcon9
 GET https://api.spacexdata.com/v2/rockets/falconheavy
 
 // Company Info
 GET https://api.spacexdata.com/v2/info
 
 // Detailed Capsule Info
 GET https://api.spacexdata.com/v2/capsules
 GET https://api.spacexdata.com/v2/capsules/dragon1
 GET https://api.spacexdata.com/v2/capsules/dragon2
 GET https://api.spacexdata.com/v2/capsules/crewdragon
 
 // LaunchPad Info
 GET https://api.spacexdata.com/v2/launchpads
 GET https://api.spacexdata.com/v2/launchpads/ksc_lc_39a
 
 // Launches
 GET https://api.spacexdata.com/v2/launches/latest
 GET https://api.spacexdata.com/v2/launches/next
 GET https://api.spacexdata.com/v2/launches
 GET https://api.spacexdata.com/v2/launches/upcoming
 GET https://api.spacexdata.com/v2/launches/all
 GET https://api.spacexdata.com/v2/launches?launch_year=2017&rocket_id=falcon9&core_reuse=true&core_serial=B1029
 
 // Capsules
 GET https://api.spacexdata.com/v2/parts/caps
 GET https://api.spacexdata.com/v2/parts/caps/C113
 GET https://api.spacexdata.com/v2/parts/caps?status=active
 
 // Cores
 GET https://api.spacexdata.com/v2/parts/cores
 GET https://api.spacexdata.com/v2/parts/cores/B1041
 GET https://api.spacexdata.com/v2/parts/cores?status=active
 
 */
