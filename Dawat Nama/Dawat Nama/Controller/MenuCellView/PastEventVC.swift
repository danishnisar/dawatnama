//
//  PastEventVC.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 04/09/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ProgressHUD

class PastEventVC: UIViewController {

    
    var refersh:UIRefreshControl={
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(red:0.25,green:0.72,blue:0.85,alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Past Events...", attributes: nil)
        refreshControl.addTarget(self, action: #selector(refrestableAction), for: UIControlEvents.valueChanged)
        return refreshControl
    }()
    let userinfo = UserDefaults.standard
    @IBOutlet weak var tablePastEvents: UITableView!
    var upcommingModel = [FetchInviation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTablview()
        
    }

    func registerTablview(){
        
        if #available(iOS 10.0, *) {
            tablePastEvents.refreshControl = refersh
        } else {
            // Fallback on earlier versions
            tablePastEvents.addSubview(refersh)
            print("not supported refresh version used")
        }
        
        tablePastEvents.delegate = self
        tablePastEvents.dataSource = self
        tablePastEvents.register(UINib(nibName: "UpCommingTblVCell", bundle: nil), forCellReuseIdentifier: "upcommingCell")
        pastEventNetworking()
        
    }
   
    //MARK: - RefreshControll Target
    @objc func refrestableAction(){
        pastEventNetworking()
    }
    
    @IBAction func quitePastEvent(_ sender: UIButton) {
    
        dismiss(animated: true, completion: nil)
    
    }
    

    private func pastEventNetworking(){
        self.refersh.beginRefreshing()
        let UserINFO = userinfo.value(forKey: "LoggedIN") as! Dictionary<String,String>
       
        
        let param = ["sender_id":UserINFO["ID"],"phone_number":UserINFO["Phone"]] as! [String:String]
        
        Alamofire.request(RestFull.fetchPastEvent, method: .post, parameters: param).responseJSON { (response) in
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
        }
        
    }
    
    private func extraactJSON(data:JSON){
        let datacount = data["result"]["invitations"].count
        print(data)
        upcommingModel = [FetchInviation]()
        //return
        for info in 0..<datacount {
            
            
            upcommingModel.append(FetchInviation(invitation_type: data["result"]["invitations"][info]["event_name"].stringValue,
                                                 host_1: data["result"]["invitations"][info]["host_1"].stringValue,
                                                 venue_name: data["result"]["invitations"][info]["venue_name"].stringValue,
                                                 rsvp_name_3: data["result"]["invitations"][info]["rsvp_name_3"].stringValue,
                                                 video_url: data["result"]["invitations"][info]["video_url"].stringValue,
                                                 invitation_count: data["result"]["invitations"][info]["invitation_count"].stringValue,
                                                 host_2_parent: data["result"]["invitations"][info]["host_2_parent"].stringValue,
                                                 din_time: data["result"]["invitations"][info]["din_time"].stringValue,
                                                 rsvp_number_3: data["result"]["invitations"][info]["rsvp_number_3"].stringValue,
                                                 host_2: data["result"]["invitations"][info]["host_2"].stringValue,
                                                 nikkah_time: data["result"]["invitations"][info]["nikkah_time"].stringValue,
                                                 sender_id: data["result"]["invitations"][info]["sender_id"].stringValue,
                                                 event_name: data["result"]["invitations"][info]["event_name"].stringValue,
                                                 id: data["result"]["invitations"][info]["id"].stringValue,
                                                 rsvp_name_1: data["result"]["invitations"][info]["rsvp_name_1"].stringValue,
                                                 new_video_url: data["result"]["invitations"][info]["new_video_url"].stringValue,
                                                 event_date: data["result"]["invitations"][info]["event_date"].stringValue,
                                                 invitation_limit: data["result"]["invitations"][info]["invitation_limit"].stringValue,
                                                 image_url: data["result"]["invitations"][info]["image_url"].stringValue,
                                                 rsvp_number_1: data["result"]["invitations"][info]["rsvp_number_1"].stringValue,
                                                 rsvp_number_2: data["result"]["invitations"][info]["rsvp_number_2"].stringValue,
                                                 rsvp_name_4: data["result"]["invitations"][info]["rsvp_name_4"].stringValue,
                                                 sender_name: "noName",
                                                 rsvp_number_4: data["result"]["invitations"][info]["rsvp_number_4"].stringValue,
                                                 event_cat_id: data["result"]["invitations"][info]["event_cat_id"].stringValue,
                                                 gender: data["result"]["invitations"][info]["gender"].stringValue,
                                                 date: data["result"]["invitations"][info]["date"].stringValue,
                                                 rsvp_name_2: data["result"]["invitations"][info]["rsvp_name_2"].stringValue,
                                                 host_1_parent: data["result"]["invitations"][info]["host_1_parent"].stringValue,
                                                 location: data["result"]["invitations"][info]["location"].stringValue,
                                                 arr_time: data["result"]["invitations"][info]["arr_time"].stringValue,
                                                 time_label: data["result"]["invitations"][info]["time_label"].stringValue,
                                                 invitation_side: data["result"]["invitations"][info]["invitation_side"].stringValue))
        }
        
        
        DispatchQueue.main.async {
            
            self.tablePastEvents.reloadData()
            self.refersh.endRefreshing()
        }
    }
    
    
}


extension PastEventVC:UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcommingModel.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "upcommingCell", for: indexPath) as! UpCommingTblVCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.eventTitle.text = upcommingModel[indexPath.row].event_name
        cell.dates.text = upcommingModel[indexPath.row].event_date
        cell.invites.text = "\(upcommingModel[indexPath.row].invitation_limit)/\(upcommingModel[indexPath.row].invitation_count)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 99.0
    }
    
    
}
