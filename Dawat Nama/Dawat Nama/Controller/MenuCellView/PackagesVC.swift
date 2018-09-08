//
//  PackagesVC.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 04/09/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ProgressHUD

class PackagesVC: UIViewController {

    
    
     var refersh : UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(red:0.25,green:0.72,blue:0.85,alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Packages...", attributes: nil)
        refreshControl.addTarget(self, action: #selector(refrestableAction), for: UIControlEvents.valueChanged)
        return refreshControl
    }()
    
    @IBOutlet weak var tablePackges: UITableView!
    var walletModel = [PackagesModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerTablview()
        // Do any additional setup after loading the view.
    }

  
    

    
    func registerTablview(){
        ProgressHUD.show()
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
       
        walletNetworking()
        
    }
    
    //MARK: - RefreshControll Target
    @objc func refrestableAction(){
        print("start refreshing")
        walletNetworking()
        //refersh.endRefreshing()
        print("end refreshing")
    }
    
    
    @IBAction func quitepackages(_ sender: UIButton) {
                dismiss(animated: true, completion: nil)
    }
    
    private func walletNetworking(){
        
        
        Alamofire.request(RestFull.fetchWallet).responseJSON(completionHandler: { (response) in
            
            if let err = response.result.error{
                ProgressHUD.showError("Loading Failed")
                print(err.localizedDescription)
                ToastView.shared.short(self.view, txt_msg: "Internet connectivity issue")
                ProgressHUD.dismiss()
                return
            }
            let responsevalueJson = JSON(response.result.value!)
            self.extraactJSON(data:responsevalueJson)
            
            ProgressHUD.dismiss()
           self.refersh.endRefreshing()
        })
        
    }
    
    private func extraactJSON(data:JSON){
        //output: an array named data having fields (plan_id, name, readem_points, price) (it’s READEM)
        
        if  let status =  data["result"]["status"].string {
            if status == "success" {
                let datacount = data["result"]["data"].count
                
                walletModel = [PackagesModel]()
                for info in 0..<datacount {
                   let plan =  data["result"]["data"][info]["plan_id"].stringValue
                   let name =  data["result"]["data"][info]["name"].stringValue
                   let price = data["result"]["data"][info]["price"].stringValue
                   let points = data["result"]["data"][info]["readem_points"].stringValue
                    
                    walletModel.append(PackagesModel(plan_id: plan, name: name, price: price, readem: points))
                }
                
              
                DispatchQueue.main.async {
                    self.tablePackges.reloadData()
                }
                
                
                
                
                
            }else{
                
                ToastView.shared.long(self.view, txt_msg: "Package Section contain issue please report to Dawatnama")
                
            }
        }
    }
    
}


extension PackagesVC:UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return walletModel.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pkgtblcell", for: indexPath) as! PackgesTblVCell
        cell.packagetitle.text = walletModel[indexPath.row].name
        cell.points.text = walletModel[indexPath.row].readem_points
        cell.prive.text = walletModel[indexPath.row].price
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 173
    }
    
    
}
