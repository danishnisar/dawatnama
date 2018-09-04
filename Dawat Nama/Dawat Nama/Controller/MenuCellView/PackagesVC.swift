//
//  PackagesVC.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 04/09/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class PackagesVC: UIViewController {

    
    
    var refersh:UIRefreshControl{
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refrestableAction), for: UIControlEvents.touchDown)
        return refreshControl
    }
    
    @IBOutlet weak var tablePackges: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerTablview()
        // Do any additional setup after loading the view.
    }

  
    

    
    func registerTablview(){
        
        if #available(iOS 10.0, *) {
            tablePackges.refreshControl = refersh
        } else {
            // Fallback on earlier versions
            tablePackges.addSubview(refersh)
            print("not supported refresh version used")
        }
        
        tablePackges.delegate = self
        tablePackges.dataSource = self
        tablePackges.register(UINib(nibName: "PackgesTblVCell", bundle: nil), forCellReuseIdentifier: "pkgtblcell")
        
        
    }
    
    //MARK: - RefreshControll Target
    @objc func refrestableAction(){
        //refersh.endRefreshing()
    }
    
    
    @IBAction func quitepackages(_ sender: UIButton) {
                dismiss(animated: true, completion: nil)
    }
    
}


extension PackagesVC:UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pkgtblcell", for: indexPath) as! PackgesTblVCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 173
    }
    
    
}
