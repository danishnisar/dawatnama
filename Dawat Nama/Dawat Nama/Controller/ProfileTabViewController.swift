//
//  ProfileTabViewController.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 17/07/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class ProfileTabViewController: UIViewController,TabSwiper {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Home Tab Loaded")
        InitSwipView(direction: .right )
        // Do any additional setup after loading the view.
    }
    func HandleSwipe(_ Sender: UISwipeGestureRecognizer) {
        if Sender.direction == .right {
            UIView.animate(withDuration: 0.5) {
                self.tabBarController?.selectedIndex = 1
            }
            
        }
    }
    

  

}
