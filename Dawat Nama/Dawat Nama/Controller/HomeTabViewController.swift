//
//  HomeTabViewController.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 17/07/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeTabViewController: UIViewController,TabSwiper {

    @IBOutlet weak var tableHome: UITableView!
    let userINFO = UserDefaults.standard
    
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    
    //Model Class For Invitaion
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var indicatorViewHeightConstraint: NSLayoutConstraint!
   // var FetchIniteModel = [FetchInviation]()
      var FetchIniteModel = [FetchInviation]()
   // var OldFetchIniteModel = [FetchInviation]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        indicatorViewHeightConstraint.constant = 0
        tableViewHeightConstraint.constant = 50
        indicatorActivity.isHidden = true
        
    
        //userINFO.removeObject(forKey: "token")
        print("HomeTab Loaded")
        print("View did Load")
        
        InitSwipView(direction:.left)
        // Do any additional setup after loading the view.
        tableHome.delegate = self
        tableHome.dataSource = self
        tableHome.register(UINib(nibName: "TblBaseHome", bundle: nil), forCellReuseIdentifier: "cellBasehome")
        
        
        if userINFO.bool(forKey: "token"){
            userTokenCheckAndloadNetowrk()
        }else{
            print("Token not found")
        }
       
        
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Will Appear")
       
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Did Appear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Did Dis Appear===>")
    }
    
    
    func HandleSwipe(_ Sender: UISwipeGestureRecognizer) {
       
        if Sender.direction == .left {
            tabBarController?.selectedIndex = 1
            
        }
        
        
        
    }
    
  
    
    
    private func LoadData(url:String,param:[String:String]){
        
        Alamofire.request(url, method: .post, parameters: param).responseJSON { (response) in
            if response.result.isSuccess {
                
                let data : JSON = JSON(response.result.value!)
                self.extractJSONData(data: data)
                print("extractJSONData function loaded")
            }
            else{
                print(response.result.error!,"Load Data Error")
            }
            
        }
    }
    
    
    private func extractJSONData(data:JSON){
        print("extractJSONData =>",data)
        
        let lineFlow = data["result"]["invitations"]
        print("=>Counting<=",lineFlow.count)
        //print("ResultCount",userINFO.integer(forKey: "ResultCount"))
        
//        if userINFO.integer(forKey: "ResultCount") == lineFlow.count {
//            print("no New Data Found")
//        }else{
        
            for i in 0..<lineFlow.count{
                userINFO.set(lineFlow.count, forKey: "ResultCount")
            FetchIniteModel.append(FetchInviation(invitation_type:lineFlow[i]["invitation_type"].stringValue,host_1: lineFlow[i]["host_1"].stringValue,venue_name: lineFlow[i]["venue_name"].stringValue,rsvp_name_3: lineFlow[i]["rsvp_name_3"].stringValue,video_url: lineFlow[i]["video_url"].stringValue,invitation_count: lineFlow[i]["invitation_count"].stringValue,host_2_parent: lineFlow[i]["host_2_parent"].stringValue,din_time: lineFlow[i]["din_time"].stringValue,rsvp_number_3: lineFlow[i]["rsvp_number_3"].stringValue,host_2: lineFlow[i]["host_2"].stringValue,sender_id: lineFlow[i]["sender_id"].stringValue,event_name: lineFlow[i]["event_name"].stringValue,id: lineFlow[i]["id"].stringValue,rsvp_name_1: lineFlow[i]["rsvp_name_1"].stringValue,new_video_url: lineFlow[i]["new_video_url"].stringValue,event_date: lineFlow[i]["event_date"].stringValue,invitation_limit: lineFlow[i]["invitation_limit"].stringValue,image_url: lineFlow[i]["image_url"].stringValue,rsvp_number_1: lineFlow[i]["rsvp_number_1"].stringValue,rsvp_number_2: lineFlow[i]["rsvp_number_2"].stringValue,rsvp_name_4: lineFlow[i]["rsvp_name_4"].stringValue,sender_name: lineFlow[i]["sender_name"].stringValue,rsvp_number_4: lineFlow[i]["rsvp_number_4"].stringValue,event_cat_id: lineFlow[i]["event_cat_id"].stringValue,gender: lineFlow[i]["gender"].stringValue,date: lineFlow[i]["date"].stringValue,rsvp_name_2: lineFlow[i]["rsvp_name_2"].stringValue,host_1_parent: lineFlow[i]["host_1_parent"].stringValue,location: lineFlow[i]["location"].stringValue,arr_time: lineFlow[i]["arr_time"].stringValue,time_label: lineFlow[i]["time_label"].stringValue,invitation_side: lineFlow[i]["invitation_side"].stringValue))
                
            }
                DispatchQueue.main.async {
                    self.loadIndicator(status:false)
                    self.tableHome.reloadData()
                    self.assignModelDataToGlobalModel()
                }
            
        }
    

    
    func userTokenCheckAndloadNetowrk(){
        //MARK: - LoadNetworking Parameter
            self.loadIndicator(status:true)
            let auth = userINFO.value(forKey: "LoggedIN") as! Dictionary<String,String>
            //userINFO.removeObject(forKey: "LoggedIN")
            print(auth)
            let param = ["sender_id":auth["ID"]!,"phone_number":auth["Phone"]!]
            
            //MARK: - LoadNetworking Alamofire
            LoadData(url: RestFull.fetchInvitationURL, param: param)
           // assignModelDataToGlobalModel()
    }
    
    func assignModelDataToGlobalModel(){
        let selectModel = tabBarController as! TabBarViewController
        selectModel.invitationGlobalModel = FetchIniteModel
    }
  
    private func loadIndicator(status:Bool){
        
        
        if status {
            
            tableViewHeightConstraint.constant = 100
            indicatorViewHeightConstraint.constant = 50
            indicatorActivity.startAnimating()
            indicatorActivity.isHidden = false
            
        }else {
            tableViewHeightConstraint.constant = 50
            indicatorViewHeightConstraint.constant = 0
            indicatorActivity.stopAnimating()
            indicatorActivity.isHidden = true

        }
        
    }

}

extension HomeTabViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FetchIniteModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellbase = tableView.dequeueReusableCell(withIdentifier: "cellBasehome", for: indexPath) as! TblBaseHome
        cellbase.heading.text = FetchIniteModel[indexPath.row].event_name
        if FetchIniteModel[indexPath.row].event_name == "Birthday" {
            
            cellbase.centerLabel.isHidden =  true
            cellbase.senderName.text = "\(FetchIniteModel[indexPath.row].event_name) \(FetchIniteModel[indexPath.row].gender)"
            cellbase.lastLable.text = FetchIniteModel[indexPath.row].host_1
            cellbase.invitemsg.text = "\(FetchIniteModel[indexPath.row].sender_name) has invited you in \(FetchIniteModel[indexPath.row].event_name)"
            
        }else{
        cellbase.senderName.text =  FetchIniteModel[indexPath.row].host_1
            cellbase.centerLabel.text = FetchIniteModel[indexPath.row].event_name == "Barat" ? "Weds" : "none"
        cellbase.lastLable.text = FetchIniteModel[indexPath.row].host_2
        cellbase.invitemsg.text = "\(FetchIniteModel[indexPath.row].sender_name) has invited you in \(FetchIniteModel[indexPath.row].event_name)"
        }
        
        return cellbase
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 272.5
    }

    
    
}
