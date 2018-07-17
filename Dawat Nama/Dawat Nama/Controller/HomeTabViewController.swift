//
//  HomeTabViewController.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 17/07/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class HomeTabViewController: UIViewController,TabSwiper {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("HomeTab Loaded")
        InitSwipView(direction:.left)
        // Do any additional setup after loading the view.
    }
    
    func HandleSwipe(_ Sender: UISwipeGestureRecognizer) {
       
        if Sender.direction == .left {
            tabBarController?.selectedIndex = 1
        }
    }

  

}
