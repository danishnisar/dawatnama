//
//  HomeDetailVC.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 07/09/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit
import WebKit
class HomeDetailVC: UIViewController,WKUIDelegate {

    @IBOutlet weak var view1Image: UIImageView!
    
    @IBOutlet weak var view2image: UIImageView!
    
    @IBOutlet weak var view3image: UIImageView!
    
    var recivedData = [FetchInviation]()
    
    
    //    MARK: - All Labels
    
    @IBOutlet weak var cermonyTitle: UILabel!
    @IBOutlet weak var host1: UILabel!
    @IBOutlet weak var host1parent: UILabel!
    @IBOutlet weak var host2: UILabel!
    @IBOutlet weak var host2parent: UILabel!
    @IBOutlet weak var withfamily: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var datefront: UILabel!
    @IBOutlet weak var nikkah: UILabel!
    @IBOutlet weak var nikkahfront: UILabel!
    @IBOutlet weak var arrival: UILabel!
    @IBOutlet weak var arrivalfront: UILabel!
    @IBOutlet weak var dinner: UILabel!
    @IBOutlet weak var dinnerfront: UILabel!
    @IBOutlet weak var venue: UILabel!
    @IBOutlet weak var resvptitle: UILabel!
    @IBOutlet weak var rsvp1: UILabel!
    @IBOutlet weak var rsvp1front: UILabel!
    @IBOutlet weak var rsvp2: UILabel!
    @IBOutlet weak var rsvp2front: UILabel!
    @IBOutlet weak var rsvp3: UILabel!
    @IBOutlet weak var rsvp3front: UILabel!
    @IBOutlet weak var rsvp4: UILabel!
    @IBOutlet weak var rsvp4front: UILabel!
    @IBOutlet weak var rsvpbottom: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    

        NotificationCenter.default.post(name: NSNotification.Name("getvideoURL"), object: nil, userInfo: ["video":recivedData[0].video_url])
        print("reciveddata",recivedData[0].event_cat_id,recivedData[0].event_name)
    }
    @IBAction func locationAction(_ sender: UIButton) {
    
    }
    private func updateUI(){
        
        if recivedData[0].event_cat_id == "1" {
            print("event name1 ",recivedData[0].event_name)
        }else if recivedData[0].event_cat_id == "2" {
            print("event name1 ",recivedData[0].event_name)
        }else if recivedData[0].event_cat_id == "3" {
            print("event name1 ",recivedData[0].event_name)
        }else{
            print("event name1 ",recivedData[0].event_name)
        }
        
    }
    
    
}
