//
//  ThirdContactViewController.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 01/08/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit
import Contacts
import Alamofire
import SwiftyJSON
import ProgressHUD
import MessageUI

class ThirdContactViewController: UIViewController {

    //MARK: - Variables,Constant and Outlets
    
    @IBOutlet weak var contacttblView: UITableView!
    @IBOutlet weak var sendInviteOutlet: UIButton!
    var familyorNot = false
    var invitecount = 1
    var dataCollect:Dictionary = [String:String]()
    var contactModel = [ContactModel]()
    var searchArray = [ContactModel]()
    var collectselctNUmber = [ContactModel]()
    
    //parameter collection array
    var param:Dictionary = [String:Any]()
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
   
    //sendsmscheck
    var sendsmscheck = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.()
        //Mark: - Fetch Contact Function
        
        //Check and confirm to move on home
        
        
        //Mark: - Contatc Cell Nib Register
        //setFamilyOrNot()
        print(dataCollect)
        searchBarOutlet.delegate = self
        searchBarOutlet.returnKeyType = .done
        contactCell()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("sendsmscheck\(sendsmscheck)")
        if sendsmscheck {
            gotohome()
        }else{
            setFamilyOrNot()
            fetchContatcs()
            //searchArray = contactModel

        }
        
    }
    
    //after send message inform customer and return to home
    
    private func gotohome(){
        let alert = UIAlertController(title: "Invitation", message: "Invitation sent sucessfully", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (okay) in
            self.performSegue(withIdentifier: "gotohome", sender: self)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    
   
    override func viewDidDisappear(_ animated: Bool) {
        sendsmscheck = false
    }
    
    func contactCell(){
        
        contacttblView.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "contactcell")
        
        
    }
    
    
    //MARK: - Fetch Contacts
    private func fetchContatcs(){
        print("Fetching Contatc Start")
        
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (granted, err) in
            if let err = err {
                print("Error in accesing the contatc",err)
                let alert = UIAlertController(title: "allow contact", message: "allow contatc", preferredStyle: .alert)
                let actionadd = UIAlertAction(title: "setting", style: .default, handler: { (alertaction) in
                    guard let settingurl = URL(string: UIApplicationOpenSettingsURLString) else {
                        return
                    }
                    
                    if #available(iOS 10.0,*)
                    {
                        UIApplication.shared.open(settingurl, options: [:], completionHandler: { (succss) in
                            print("success 10")
                        })
                    }else{
                        UIApplication.shared.openURL(settingurl)
                    }
                })
                alert.addAction(actionadd)
                self.present(alert, animated: true, completion: nil)
                
            }
            
            if granted {
                print("access Granted")
                
                
                //MARK: - Fetching Start
                let Keys = [CNContactGivenNameKey,CNContactPhoneNumbersKey,CNContactImageDataKey]
                let request = CNContactFetchRequest(keysToFetch: Keys as [CNKeyDescriptor])
                
                DispatchQueue.global().async {
                    
                    do {
                        try store.enumerateContacts(with: request) { (contact, StopPointerIfYouWantToStopEnum) in
                            
                            
                            if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
                                
//                                print(contact.givenName)
//                                print(phoneNumber)
//                                print(contact.imageData ?? "N/A")
                                
                                var name = contact.givenName
                                let number = phoneNumber
                                
                                if contact.givenName == "" {
                                     name = "Unknown"
                                }
                                
                                // let arramodel = [name,number,"N/A"]
                                self.contactModel.append(ContactModel(name: name, phone: number, image: "N/A",select:false))
                                
                            }
                            
                            
                        }
                        DispatchQueue.main.async {
                            self.searchArray = self.contactModel
                          self.contacttblView.reloadData()
                        }
                    }catch let err {
                        print("fatal error",err)
                    }
                    
                    
                }

             
               
                
            }else{
                print("access denied")
            }
            
            
        }
        
        
        
        
    }
    
    func setFamilyOrNot(){
        let AlertControl = UIAlertController(title: "Opinion", message: "Would you Like to Send Invitation With Family", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            print("Yes")
            self.familyorNot = true
            self.sendInviteOutlet.titleLabel?.text = "Send Invitaion with Family"
            
        }
        let noAction = UIAlertAction(title: "No", style: .default) { (action) in
            print("No")
            self.familyorNot = false
            self.sendInviteOutlet.titleLabel?.text = "Send Invitaion"
        }
        AlertControl.addAction(noAction)
        AlertControl.addAction(yesAction)
        present(AlertControl, animated: true) {
            print("alert completetion")
        }
        
    }
    
    @IBAction func sendInviatonFinaly(_ sender: Any) {
        
        networkFire()
    }
    

    
    func networkFire(){
        //["Barat", "3", "Birthday Side", "tf", "Boy", "ggg", "tg", "fcf", "fcff", "KaimKhani Ground Sector 5 Orangi Town, Karachi, Karachi City, Sindh, Sector 5 Orangi Town, Karachi, Karachi City, Sindh, Pakistan", "10/292/2018", "03:08", "03:08", "gggggggg", "25555", "", "", "", "", "Lunch", "03:08", "1", "https://firebasestorage.googleapis.com/v0/b/dawat-nama.appspot.com/o/videos%2FinvoteVideoiOS-2018-08-18%2022:55:15%20%2B0000.mp4?alt=media&token=cd97a6f3-cb22-497d-9635-8fb8fe7af887"]
        
        

        if dataCollect["invitationInput"] == "1" {
            
             param = ["event_cat_id":dataCollect["invitationInput"]!,
                         "sender_id":dataCollect["sendreID"]!,
                         "invitation_side":dataCollect["side"]!,
                         "host_1":dataCollect["GroomInput.text!"]!,
                         "gender":dataCollect["segmentSelect"]!,
                         "host_1_parent":dataCollect["GroomSonInput.text!"]!,
                         "host_2":dataCollect["BrideInput.text!"]!,
                         "host_2_parent":dataCollect["BrideDaughterInput.text!"]!,
                         "venue_location":dataCollect["VenuInput.text!"]!,
                         "location":dataCollect["locationInput.text!"]!,
                         "date":dataCollect["DateInput.text!"]!,
                         "nikkah_time":dataCollect["NikkahTimeInput.text!"]!,
                         "arr_time":dataCollect["ArrivalTimeInput.text!"]!,
                         "time_label":dataCollect["LunchOrDinnerInput"]!,
                         "din_time":dataCollect["LuncOrDinnerTimeInput"]!,
                         "rsvp_name_1":dataCollect["resvp_name_0"]!,
                         "rsvp_number_1":dataCollect["resvp_number_1"]!,
                         "rsvp_name_2":dataCollect["resvp_name_2"]!,
                         "rsvp_number_2":dataCollect["resvp_number_3"]!,
                         "rsvp_name_3":dataCollect["resvp_name_4"]!,
                         "rsvp_number_3":dataCollect["resvp_number_5"]!,
                         "rsvp_name_4":"",
                         "rsvp_number_4":"",
                         "video_url":dataCollect["video_url"]!,
                         "video_name":dataCollect["video_name"]!,
                         "invitation_limit":dataCollect["numberofInvite"]!,
                         "invitation_count":collectselctNUmber.count
                ]
            
            
        }else if dataCollect["invitationInput"] == "2" || dataCollect["invitationInput"] == "3"  {
             param = ["event_cat_id":dataCollect["invitationInput"]!,
                         "sender_id":dataCollect["sendreID"]!,
                         "invitation_side":dataCollect["side"]!,
                         "host_1":dataCollect["GroomInput.text!"]!,
                         "gender":dataCollect["segmentSelect"]!,
                         "host_1_parent":dataCollect["GroomSonInput.text!"]!,
                         "host_2":dataCollect["BrideInput.text!"]!,
                         "host_2_parent":dataCollect["BrideDaughterInput.text!"]!,
                         "venue_location":dataCollect["VenuInput.text!"]!,
                         "location":dataCollect["locationInput.text!"]!,
                         "date":dataCollect["DateInput.text!"]!,
                         "nikkah_time":dataCollect["NikkahTimeInput.text!"]!,
                         "arr_time":dataCollect["ArrivalTimeInput.text!"]!,
                         "time_label":dataCollect["LunchOrDinnerInput"]!,
                         "din_time":dataCollect["LuncOrDinnerTimeInput"]!,
                         "rsvp_name_1":dataCollect["resvp_name_0"]!,
                         "rsvp_number_1":dataCollect["resvp_number_1"]!,
                         "rsvp_name_2":dataCollect["resvp_name_2"]!,
                         "rsvp_number_2":dataCollect["resvp_number_3"]!,
                         "rsvp_name_3":dataCollect["resvp_name_4"]!,
                         "rsvp_number_3":dataCollect["resvp_number_5"]!,
                         "rsvp_name_4":"",
                         "rsvp_number_4":"",
                         "video_url":dataCollect["video_url"]!,
                         "video_name":dataCollect["video_name"]!,
                         "invitation_limit":dataCollect["numberofInvite"]!,
                         "invitation_count":collectselctNUmber.count
                ]

        }else {
            
             param = ["event_cat_id":dataCollect["invitationInput"]!,
                         "sender_id":dataCollect["sendreID"]!,
                         "invitation_side":dataCollect["side"]!,
                         "host_1":dataCollect["GroomInput.text!"]!,
                         "gender":dataCollect["segmentSelect"]!,
                         "host_1_parent":dataCollect["GroomSonInput.text!"]!,
                         "host_2":dataCollect["BrideInput.text!"]!,
                         "host_2_parent":dataCollect["BrideDaughterInput.text!"]!,
                         "venue_location":dataCollect["VenuInput.text!"]!,
                         "location":dataCollect["locationInput.text!"]!,
                         "date":dataCollect["DateInput.text!"]!,
                         "nikkah_time":dataCollect["NikkahTimeInput.text!"]!,
                         "arr_time":dataCollect["ArrivalTimeInput.text!"]!,
                         "time_label":dataCollect["cakeinput"]!,
                         "din_time":dataCollect["cakeTime"]!,
                         "rsvp_name_1":dataCollect["resvp_name_0"]!,
                         "rsvp_number_1":dataCollect["resvp_number_1"]!,
                         "rsvp_name_2":dataCollect["resvp_name_2"]!,
                         "rsvp_number_2":dataCollect["resvp_number_3"]!,
                         "rsvp_name_3":dataCollect["resvp_name_4"]!,
                         "rsvp_number_3":dataCollect["resvp_number_5"]!,
                         "rsvp_name_4":"",
                         "rsvp_number_4":"",
                         "video_url":dataCollect["video_url"]!,
                         "video_name":dataCollect["video_name"]!,
                         "invitation_limit":dataCollect["numberofInvite"]!,
                         "invitation_count":collectselctNUmber.count
            ]
            
        }
        
   // print(param)
        for i in 0..<100{
            
            if i >= collectselctNUmber.count {
                param["contact_name_\(i+1)"] = "no_name"
                param["contact_number_\(i+1)"] = "no_number"
                param["invitation_type_\(i+1)"] = familyorNot ? "With family":"Single"
                
            }else {
                
                param["contact_name_\(i+1)"] = collectselctNUmber[i].CNName
                param["contact_number_\(i+1)"] = collectselctNUmber[i].CNPhone
                param["invitation_type_\(i+1)"] = familyorNot ? "With family":"Single"
                print("selected name",collectselctNUmber[i].CNName,"selected number",collectselctNUmber[i].CNPhone)
                
               
                
            }
        
           
        }
      // print(param)


        //https://admiria.pk/marriage/api/invitations
        ProgressHUD.show("Loading...")
        Alamofire.request(RestFull.post_Invitation, method: .post, parameters: param).responseJSON{ (response) in
            
            if let err = response.result.error {
                print("Parameter=",self.param)
                print("Alamofire Error:",err)
                ProgressHUD.showError("Internet issue please check Connectecion")
                return
            }
            

            ProgressHUD.dismiss()
            let jsonData = JSON(response.result.value!)
            self.extractJson(data: jsonData)
        }
    }
    
    private func extractJson(data:JSON){
//        var name=[String]();
        var number=[String]()
        var textmessage = "These number not have Dawatnama Application\n"
        print(data)
     //   let walletamount = data["result"]["updated_amount"].intValue
        let count = data["result"]["numbers"].count
        print(count)
        
        if count == 0 {
            
            gotohome()
            
            
        }else {
            for i in 0..<data["result"]["numbers"].count{
                textmessage += "\(data["result"]["numbers"][i]["i_name"]) : \(data["result"]["numbers"][i]["contact_number"])\n"
                number.append((data["result"]["numbers"][i]["contact_number"].stringValue))
            }
            
            let confirmAction = UIAlertController(title: "Send SMS", message: textmessage, preferredStyle: .alert)
            let cancel  = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
                print("Cancel")
            }
            let sendsms = UIAlertAction(title: "Send SMS", style: .default) { (sms) in
                ProgressHUD.show()
                self.opensmsController(recipent: number)
                print("sendsms")
            }
            confirmAction.addAction(cancel)
            confirmAction.addAction(sendsms)
            
            present(confirmAction, animated: true, completion: nil)
            
            
        }
        
        
    }
    
    
    
}

extension ThirdContactViewController:MFMessageComposeViewControllerDelegate{
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        sendsmscheck = true
        
        controller.dismiss(animated: true)
//        performSegue(withIdentifier: "gotohome", sender: self)
   
    }

    
    private func opensmsController(recipent:[String]){
        
        if MFMessageComposeViewController.canSendText() {
            let controler  = MFMessageComposeViewController()
            controler.messageComposeDelegate = self
            controler.body = "Need to send text for download app"
            controler.recipients = recipent
            self.present(controler, animated: true)
        }
        else{
            ToastView.shared.short(self.view, txt_msg: "SMS Services are nto available")
        }
        ProgressHUD.dismiss()
    }
}


extension ThirdContactViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactcell", for: indexPath) as! ContactTableViewCell
        cell.CNName.text = "\(contactModel[indexPath.row].CNName)"
        cell.CNNumber.text = "\(contactModel[indexPath.row].CNPhone)"
        //cell.CNName.text +=
       // cell.checkMark.addTarget(self, action: #selector(checkMarpresed(_:)), for: .touchUpInside)
        cell.accessoryType = contactModel[indexPath.row].selec ? .checkmark : .none
        
        
        return cell
    }
    
    

    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
        
            if invitecount > Int(dataCollect["numberofInvite"]!)! {
               invitecount -= 1
            }
            
            collectselctNUmber.remove(at: 0)
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            contactModel[indexPath.row].selec = false

        }else {
           
            if invitecount > Int(dataCollect["numberofInvite"]!)! {
                print("no more selection need")
                return
            }
            
            collectselctNUmber.append(ContactModel(name: contactModel[indexPath.row].CNName, phone: contactModel[indexPath.row].CNPhone, image: "", select: true))

            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
            contactModel[indexPath.row].selec = true
            invitecount += 1
        }
        
        for i in 0..<collectselctNUmber.count {
            print(collectselctNUmber[i].CNName,collectselctNUmber[i].CNPhone)
        }
        
     }
    

//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        contactModel[indexPath.row].selec = false
//    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    @objc private func checkMarpresed(_ sender:UIButton){
       
        if sender.isSelected {
            sender.isSelected = false
        }else {
            sender.isSelected = true
        }
    }
    
    
    
    
}

extension ThirdContactViewController:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty  else {
            searchArray = contactModel;
            contacttblView.reloadData()
            //searchBar.resignFirstResponder()
            return
        }
        
        contactModel = contactModel.filter({ (model) -> Bool in
            model.CNName.lowercased().contains(searchText.lowercased())
        })
        
        contacttblView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("done button")
        searchBar.resignFirstResponder()
    }
    
    
}










