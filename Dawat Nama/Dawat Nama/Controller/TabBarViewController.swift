//
//  TabBarViewController.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 16/07/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillLayoutSubviews() {
        
        var tabbar = tabBar.frame
        tabbar.origin.y = view.frame.origin.y
        tabBar.frame = tabbar
    }
   

}
