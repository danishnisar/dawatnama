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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

extension MenuVC:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menucell", for: indexPath) as! MenuCell
        cell.label.text = MenuData[indexPath.row]
        return cell
    }
}
