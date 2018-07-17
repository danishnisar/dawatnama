//
//  AlertTabViewController.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 17/07/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class AlertTabViewController: UIViewController,TabSwiper {

    //MARK :- Added Variable Of IBOUTLET & IBACTION
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Alert Loaded")

            InitSwipView(direction: .left)
            InitSwipView(direction: .right)
            CellReg()
        
    }
    func HandleSwipe(_ Sender: UISwipeGestureRecognizer) {
        if Sender.direction == .left {
            tabBarController?.selectedIndex = 2
        }
        if Sender.direction == .right {
            tabBarController?.selectedIndex = 0
            
        }
    }
    
    func CellReg(){
        tblView.register(UINib(nibName: "TblBaseCellView", bundle: nil), forCellReuseIdentifier: "cellBase")
    }

   

}

extension AlertTabViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellbase = tableView.dequeueReusableCell(withIdentifier: "cellBase", for: indexPath) as! TblBaseCellView
        
        return cellbase
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}










