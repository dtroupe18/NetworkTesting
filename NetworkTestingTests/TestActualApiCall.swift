//
//  TestActualApiCall.swift
//  NetworkTestingTests
//
//  Created by Dave on 5/18/18.
//  Copyright © 2018 High Tree Development. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import NetworkTesting

class TestActualNetworkCall: QuickSpec {
    // Generally you don't make a test like this because it depends on outside factors in order to be successful.
    // This is just an example of how it can be done.
    
    override func spec() {
        describe("requestRocketWithName") {
            context("sucess") {
                it("returns rocketData") {
                    var returnedRocketData: Rocket?
                    
                    // Here we are making an actual network request and checking that the returned data is valid
                    ApiClient.getRocketInfo(rocketName: "falconheavy", onSuccess: { rocketData in
                        returnedRocketData = rocketData
                    })
                    
                    // Give the request 15 seconds to finish
                    expect(returnedRocketData).toEventuallyNot(beNil(), timeout: 15)
                }
            }
        }
    }
}
