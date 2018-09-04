//
//  UpCommingEventVC.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 03/09/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class UpCommingEventVC: UIViewController {

    
    var refersh:UIRefreshControl{
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refrestableAction), for: UIControlEvents.touchDown)
        return refreshControl
    }
    
    
    @IBOutlet weak var tableupEvents: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerTablview()
       
    }
    
    func registerTablview(){
        
        if #available(iOS 10.0, *) {
            tableupEvents.refreshControl = refersh
        } else {
            // Fallback on earlier versions
            tableupEvents.addSubview(refersh)
            print("not supported refresh version used")
        }
        
        tableupEvents.delegate = self
        tableupEvents.dataSource = self
        tableupEvents.register(UINib(nibName: "UpCommingTblVCell", bundle: nil), forCellReuseIdentifier: "upcommingCell")
        
        
    }
    
    
    
    //MARK: - RefreshControll Target
    @objc func refrestableAction(){
        //refersh.endRefreshing()
    }
    

    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    

}


extension UpCommingEventVC:UITableViewDelegate,UITableViewDataSource {
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "upcommingCell", for: indexPath) as! UpCommingTblVCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 99.0
    }
    
 
}
