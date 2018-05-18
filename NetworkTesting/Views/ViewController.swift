//
//  ViewController.swift
//  NetworkTesting
//
//  Created by Dave on 5/17/18.
//  Copyright © 2018 High Tree Development. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Network calls
        ApiClient.getRocketInfo(rocketName: "falconheavy", onSuccess: { rocketData in
            print("Rocket: \(rocketData)")
        }, onError: { error in
            print("Error: \(error)")
        })
        
        ApiClient.getCompanyInfo(onSuccess: { companydata in
            print("Company: \(companydata)")
        }, onError: { error in
            print("Error: \(error)")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

