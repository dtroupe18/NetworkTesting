//
//  TestStubbedNetworkCall.swift
//  NetworkTestingTests
//
//  Created by Dave on 5/18/18.
//  Copyright © 2018 High Tree Development. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingjay

@testable import NetworkTesting

class TestStubbedApiCall: QuickSpec {
    override func spec() {
        super.spec()
        
        describe("requestRocketWithNameWithoutApiCall") {
            context("sucess") {
                it("returns rocketData") {
                    var returnedRocketData: Rocket?
                    
                    // Get the stubbed response from inside the Fixtures directory. This is response data from the
                    // SpaceX API that we know is correctly formatted. Thuse we have removed outside factors from impacting the
                    // result of this test.
                    
                    // When running tests the application bundle is still the main bundle. So we need to get the test bundle
                    let bundle: Bundle = Bundle(for: type(of: self))
                    if let path: String = bundle.path(forResource: "GetRocketSuccess", ofType: "json") {
                        let url: URL = URL(fileURLWithPath: path)
                        
                        do {
                            let simulatedJsonData: Data = try Data(contentsOf: url)
                            
                            // stub the url so that all requests to this url will use the stored JSON data and not make a network request
                            self.stub(uri("https://api.spacexdata.com/v2/rockets/falconheavy"), delay: nil, jsonData(simulatedJsonData))
                            
                            // Here make the request which will use our stubbed data
                            ApiClient.getRocketInfo(rocketName: "falconheavy", onSuccess: { rocketData in
                                returnedRocketData = rocketData
                            })
                            
                            expect(returnedRocketData).toEventuallyNot(beNil())
                            expect(returnedRocketData?.name) == "Falcon Heavy"
                            expect(returnedRocketData?.engines.thrustVacuum.lbf) == 205500
                            expect(returnedRocketData?.costPerLaunch) == 90000000
                        } catch {
                            fail("Error thrown: \(error)")
                        }
                    } else {
                        fail("Could not load GetRocketSuccess.json")
                    }
                }
            }
            
            // Error Case
            context("error") {
                it("returns error") {
                    var returnedError: Error?
                    
                    let expectedError: Error = NSError(domain: "Error here", code: 404, userInfo: nil) as Error
                    self.stub(uri("https://api.spacexdata.com/v2/rockets/falconheavy"), delay: nil, failure(expectedError as NSError))
                    
                    ApiClient.getRocketInfo(rocketName: "falconheavy", onError: { error in
                        returnedError = error
                    })
                    expect(returnedError).toEventuallyNot(beNil())
                }
            }
            
            context("jsonStructureIncorrect") {
                it("returns error") {
                    var returnedError: Error?
                    // Error we return in our ApiClient if codable fails
                    let expectedError: Error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Error data incorrectly formatted"]) as Error
                    
                    let bundle: Bundle = Bundle(for: type(of: self))
                    if let path: String = bundle.path(forResource: "GetRocketFailure", ofType: "json") {
                        let url: URL = URL(fileURLWithPath: path)
                        
                        do {
                            let simulatedJsonData: Data = try Data(contentsOf: url)
                            
                            // stub the url so that all requests to this url will use the stored JSON data and not make a network request
                            self.stub(uri("https://api.spacexdata.com/v2/rockets/falconheavy"), delay: nil, jsonData(simulatedJsonData))
                            
                            ApiClient.getRocketInfo(rocketName: "falconheavy", onError: { error in
                                returnedError = error
                            })
                            expect(returnedError).toEventuallyNot(beNil())
                            expect(returnedError?.localizedDescription) == expectedError.localizedDescription
                        } catch {
                            fail("Error thrown: \(error)")
                        }
                    } else {
                        fail("Could not load GetRocketSuccess.json")
                    }
                }
            }
        }
    }
}
