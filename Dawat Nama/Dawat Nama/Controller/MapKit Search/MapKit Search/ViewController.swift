//
//  ViewController.swift
//  MapKit Search
//
//  Created by MacBook Prp on 26/09/2018.
//  Copyright © 2018 Native Brains. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = "Pizza"
        searchRequest.region = .init()
        let search  = MKLocalSearch(request: searchRequest)
        
        search.start { (response, error) in
            if error != nil {
                print("error")
            }else {
                let itemcount = response!.mapItems.first
                itemcount?.openInMaps(launchOptions: nil)
                
            }
            
        }
        
        
        
        
        
        
        
        
        
        
    }


}

