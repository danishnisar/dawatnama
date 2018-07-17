//
//  AlertTabViewController.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 17/07/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class AlertTabViewController: UIViewController,TabSwiper {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Alert Loaded")

            InitSwipView(direction: .left)
            InitSwipView(direction: .right)
        
    }
    func HandleSwipe(_ Sender: UISwipeGestureRecognizer) {
        if Sender.direction == .left {
            tabBarController?.selectedIndex = 2
        }
        if Sender.direction == .right {
            tabBarController?.selectedIndex = 0
            
        }
    }

   

}

extension AlertTabViewController:UITableViewController,UITableViewDelegate {
    
}
