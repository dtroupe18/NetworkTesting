# NetworkTesting

Examples on how to unit test API calls using: 

[SpaceX API](https://github.com/r-spacex/SpaceX-API)

[Mockingjay](https://github.com/kylef/Mockingjay)
[Quick](https://github.com/Quick/Quick)
[Nimble](https://github.com/Quick/Nimble)

### Unit Test using Mocked Data

```swift
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
                        
                        // Stub the url so that all requests to this url will use stored JSON data
                        self.stub(uri("https://api.spacexdata.com/v2/rockets/falconheavy"), delay: nil, jsonData(simulatedJsonData))
                        
                        // Here make the request which will use our stubbed data
                        ApiClient.getRocketInfo(rocketName: "falconheavy", onSuccess: { rocketData in
                            returnedRocketData = rocketData
                        })
                        
                        // Check that we got rocket data
                        expect(returnedRocketData).toEventuallyNot(beNil())
                        
                        // Check that values were parsed correctly
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
                        
                        // Stub the url so that all requests to this url will use the stored JSON data
                        self.stub(uri("https://api.spacexdata.com/v2/rockets/falconheavy"), delay: nil, jsonData(simulatedJsonData))
                        
                        ApiClient.getRocketInfo(rocketName: "falconheavy", onError: { error in
                            returnedError = error
                        })
                        expect(returnedError).toEventuallyNot(beNil())
                        // Make sure the correct error was returned
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
```






### Test making an actual API call (not recommended)
```swift
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
```




