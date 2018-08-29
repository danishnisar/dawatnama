//
//  MenuVC.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 07/08/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    
    let MenuData = ["Upcomming Event","Past Events","View Packages","Send Recipet","Refresh","Logout"]
    
    let UserInfo = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelResponder(_ sender: Any) {
        print("Cancel button")
    }
    
    @IBAction func logoutAction(_ sender: Any) {
    UserInfo.removeObject(forKey: "token")
    UserInfo.removeObject(forKey: "LoggedIN")
        
    }
   
    
}


