//
//  HomeTabViewController.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 17/07/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class HomeTabViewController: UIViewController,TabSwiper {

    @IBOutlet weak var tableHome: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        print("HomeTab Loaded")
        InitSwipView(direction:.left)
        // Do any additional setup after loading the view.
        tableHome.delegate = self
        tableHome.dataSource = self
        tableHome.register(UINib(nibName: "TblBaseHome", bundle: nil), forCellReuseIdentifier: "cellBasehome")
        
    }
    
    func HandleSwipe(_ Sender: UISwipeGestureRecognizer) {
       
        if Sender.direction == .left {
            tabBarController?.selectedIndex = 1
        }
        
        
        
    }
    

  

}

extension HomeTabViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellbase = tableView.dequeueReusableCell(withIdentifier: "cellBasehome", for: indexPath) as! TblBaseHome
        
        return cellbase
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 191
    }

    
    
}
