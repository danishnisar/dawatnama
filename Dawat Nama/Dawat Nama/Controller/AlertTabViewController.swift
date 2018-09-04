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
    var inviteModel = [FetchInviation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Alert Loaded")

            InitSwipView(direction: .left)
            InitSwipView(direction: .right)
            CellReg()
            fetchGlobalData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if inviteModel.count == 0{
            fetchGlobalData()
        }
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

    func fetchGlobalData(){
       let fetchGlobalData = tabBarController as! TabBarViewController
        inviteModel = fetchGlobalData.invitationGlobalModel
        print(inviteModel)
        tblView.reloadData()
        
    }

}

extension AlertTabViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inviteModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellbase = tableView.dequeueReusableCell(withIdentifier: "cellBase", for: indexPath) as! TblBaseCellView
        cellbase.invitesender.text = "\(inviteModel[indexPath.row].sender_name) has invited you in \(inviteModel[indexPath.row].event_name)"
        //cellbase.eventName.text = inviteModel[indexPath.row].event_name
        cellbase.profileImage.loadCacheImage(imgUrl: inviteModel[indexPath.row].image_url)
        cellbase.eventDate.text = "Event Date: \(inviteModel[indexPath.row].event_date)"
        return cellbase
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 119.5
    }

}










