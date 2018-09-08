//
//  EventAgainVC.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 05/09/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit
import SafariServices
import ProgressHUD
import Alamofire
import SwiftyJSON

class EventAgainVC: UIViewController,SFSafariViewControllerDelegate {

    var datamigrate = [FetchInviation]()
    var dicFormate = [String:String]()
    @IBOutlet weak var nikkahConstraintHeight: NSLayoutConstraint! //54
    
    @IBOutlet weak var nikkahtimeheightConstraint: NSLayoutConstraint!//15
    @IBOutlet weak var pinmapbottomConstraint: NSLayoutConstraint! //10
    @IBOutlet weak var pinmaptopConstraint: NSLayoutConstraint!//9
    @IBOutlet weak var timetopConstraint: NSLayoutConstraint!//9
    @IBOutlet weak var nikkahtitlebottomConstraint: NSLayoutConstraint!//8
    
    
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var groomView: UIView!
    @IBOutlet weak var groomTitle: UILabel!
    @IBOutlet weak var brideView: UIView!
    @IBOutlet weak var brideTitle: UILabel!
    @IBOutlet weak var birthdayView: UIView!
    @IBOutlet weak var birthdayTitle: UILabel!
    
    @IBOutlet weak var dateTitle: UIButton!
    @IBOutlet weak var nikkahView: UIView!
    @IBOutlet weak var nikkahTitle: UIButton!
    @IBOutlet weak var arrivalTitle: UIButton!
    @IBOutlet weak var dinnerorcakelabel: UILabel!
    @IBOutlet weak var dinnerorcakeImage: UIImageView!
    @IBOutlet weak var dinnerorCakeTitle: UIButton!
    
    @IBOutlet weak var resendInvitationOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("datemigrate",datamigrate[0])
        setUp()
    }
    
    private func setUp(){
        
        if datamigrate[0].invitation_limit == datamigrate[0].invitation_count {
           resendInvitationOutlet.isHidden = true
        }else{
            resendInvitationOutlet.isHidden = false
        }
        
        if datamigrate[0].event_name == "Barat" {
            updateLayout(cond: false)
            eventName.text = datamigrate[0].event_name
            groomView.isHidden = false
            brideView.isHidden = false
            birthdayView.isHidden = true
            nikkahView.isHidden = false
            groomTitle.text = datamigrate[0].host_1
            brideTitle.text = datamigrate[0].host_2
            dateTitle.setTitle(datamigrate[0].event_date, for: UIControlState.normal)
            arrivalTitle.setTitle(datamigrate[0].arr_time, for: .normal)
            dinnerorCakeTitle.setTitle(datamigrate[0].din_time, for: UIControlState.normal)
            nikkahTitle.setTitle(datamigrate[0].nikkah_time, for: .normal)
            //dinnerorcakeImage.image = UIImage(named: "")
            dinnerorcakelabel.text = datamigrate[0].time_label
            
            
        }else if datamigrate[0].event_name == "Birthday" {
            updateLayout(cond: true)
            nikkahView.isHidden = true
            eventName.text = datamigrate[0].event_name
            birthdayView.isHidden = false
            groomView.isHidden = true
            brideView.isHidden = true
            birthdayTitle.text = datamigrate[0].host_1
            
            dateTitle.setTitle(datamigrate[0].event_date, for: UIControlState.normal)
            arrivalTitle.setTitle(datamigrate[0].arr_time, for: .normal)
            dinnerorCakeTitle.setTitle(datamigrate[0].din_time, for: UIControlState.normal)
            //dinnerorcakeImage.image = UIImage(named: "")
            dinnerorcakelabel.text = datamigrate[0].time_label
            
        }else{
            updateLayout(cond: true)
            nikkahView.isHidden = true
            eventName.text = datamigrate[0].event_name
            groomView.isHidden = false
            brideView.isHidden = false
            birthdayView.isHidden = true
            groomTitle.text = datamigrate[0].host_1
            brideTitle.text = datamigrate[0].host_2
            dateTitle.setTitle(datamigrate[0].event_date, for: UIControlState.normal)
            arrivalTitle.setTitle(datamigrate[0].arr_time, for: .normal)
            dinnerorCakeTitle.setTitle(datamigrate[0].din_time, for: UIControlState.normal)
            //dinnerorcakeImage.image = UIImage(named: "")
            dinnerorcakelabel.text = datamigrate[0].time_label
        }
        
        
    }
    @IBAction func openLocation(_ sender: UIButton) {
        //openmaporsafari
        print("Location:",datamigrate[0].location)
        var halfUrl = ""
        let splitinstance = datamigrate[0].location.split(separator: " ")
        for sp in 0..<splitinstance.count{
            halfUrl += "-"
            halfUrl += splitinstance[sp]
        }
        print("HalfUrl",halfUrl)
        let safarVC = SFSafariViewController(url: URL(string: "https://www.google.com/maps/search/\(halfUrl)/")!, entersReaderIfAvailable: true)
        
            present(safarVC, animated: true, completion: nil)
            safarVC.delegate = self
        
        
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
   
    @IBAction func quiteevent(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func viewInvites(_ sender: UIButton) {
    
        //showalert with invitation sender
        //let message = "\()"
        
        grabInvitaionDetails()
        
        
        
    
    }
    
    @IBAction func resendInvitation(_ sender: UIButton) {
        //segue decide contact or video section
        if datamigrate[0].invitation_limit == datamigrate[0].invitation_count {
            resendInvitationOutlet.isHidden = true
        }else{
            resendInvitationOutlet.isHidden = false
           
        let confrimAlert = UIAlertController(title: "Confrimation", message: "Would you like to create a new video for these invites", preferredStyle: .alert)
            let noAction = UIAlertAction(title: "No", style: .destructive) { (cancel) in
                print("No")
                 self.performSegue(withIdentifier: "eventToContact", sender: self)
            }
            let yesAction = UIAlertAction(title: "Yes", style: .default) { (submit) in
                print("Yes")
                self.performSegue(withIdentifier: "eventToUpload", sender: self)
            }
            confrimAlert.addAction(noAction)
            confrimAlert.addAction(yesAction)
            present(confrimAlert, animated: true, completion: nil)
            
        }
        
        
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventToUpload"{
            
            let vc = segue.destination as! UploadRecordVC

            
            vc.dataCollect = passDateState(condition:true)
            
        }else{
            
            let vc = segue.destination as! ThirdContactViewController
            
            vc.dataCollect = passDateState(condition:false)
            
        }
    }

    func passDateState(condition:Bool)->Dictionary<String,String>{
        var formater = dicFormate
        formater["invitation_id"] = datamigrate[0].id
        formater["sendreID"] = datamigrate[0].sender_id
        if condition {
            formater["eventtopupload"] = "yes"
//            formater["new_video_url"] = datamigrate[0].new_video_url
//            formater["new_video_name"] = datamigrate[0].video_url
       }else{
            formater["eventtopupload"] = "no"
//            formater["video_url"] = datamigrate[0].new_video_url
//            formater["video_name"] = datamigrate[0].video_url
        }
        let count = Int(datamigrate[0].invitation_limit)! - Int(datamigrate[0].invitation_count)!
        formater["invitation_count"] = "\(count)"


        return formater
    }
    
    
    func updateLayout(cond:Bool){
        
        if cond {
            
            UIView.animate(withDuration: 0.6) {
            self.nikkahConstraintHeight.constant = 0 //54
            self.nikkahtimeheightConstraint.constant = 0//15
            self.pinmapbottomConstraint.constant = 0//10
            self.pinmaptopConstraint.constant = 0//9
            self.timetopConstraint.constant = 0//9
            self.nikkahtitlebottomConstraint.constant = 0//8
                print("cond",cond)
            }
            
            
        }else{
            UIView.animate(withDuration: 0.6) {
            self.nikkahConstraintHeight.constant = 54
            self.nikkahtimeheightConstraint.constant = 15
            self.pinmapbottomConstraint.constant = 10
            self.pinmaptopConstraint.constant = 9
            self.timetopConstraint.constant = 9
            self.nikkahtitlebottomConstraint.constant = 8
                print("cond",cond)
            }
        }

        
        
        
        
    }
    
    private func grabInvitaionDetails(){
        ProgressHUD.show("Loading")
        let param = ["invitation_id":datamigrate[0].sender_id]
        
        Alamofire.request(RestFull.fetchEventsContact, method: .post, parameters: param).responseJSON { (response) in
            
            if let err = response.result.error{
                ProgressHUD.showError("Loading Failed")
                print(err.localizedDescription)
                ToastView.shared.short(self.view, txt_msg: "Internet connectivity issue")
                ProgressHUD.dismiss()
                return
            }
            
            let dataJson = JSON(response.result.value!)
            
            print(dataJson)
            self.extractJSON(data:dataJson)
            ProgressHUD.dismiss()
        }
        
        
        
    }
    
    private func extractJSON(data:JSON){
       
        let count = data["result"]["contacts"].count
        var mesage = ""
        let typeofEvent = data["result"]["contacts"][0]["invitation_type"]
        for contact in 0..<count {
            
            mesage += "\(contact+1) "
            mesage += data["result"]["contacts"][contact]["contact_name"].stringValue
            mesage += " : "
            mesage += data["result"]["contacts"][contact]["contact_number"].stringValue
            mesage += "\n"
        }
        
        
        let poup = UIAlertController(title: "Invite \(typeofEvent)", message: mesage, preferredStyle: UIAlertControllerStyle.alert)
        let actionClose = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        poup.addAction(actionClose)
        present(poup, animated: true, completion: nil)
       
    }
    
    
  
    
    
    
}
