//
//  TabBarViewController.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 16/07/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

        // Do any additional setup after loading the view.
    }

    override func viewWillLayoutSubviews() {
        
        var tabbar = tabBar.frame
        tabbar.origin.y = view.frame.origin.y
        tabBar.frame = tabbar
    }
   

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            print("transisition1")
            return false // Make sure you want this as false
        }
        
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        print("transisition2")
        return true
    }
}


