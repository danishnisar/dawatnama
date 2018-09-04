//
//  ViewController.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 12/07/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class MainViewController: UIViewController{
   
    @IBOutlet weak var menuContainerConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainContainerConstraint: UIView!
    var menuConstraintToggle = false ;
    // Mark :- IBOUTLETs Home View
    //Mark :- Var let Vairables
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileWallet: DesginUILabelField!
    @IBOutlet weak var profileStatus: UILabel!
    
    
    let UserInfo = UserDefaults.standard
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        UserInfo.removeObject(forKey: "token")
//        UserInfo.removeObject(forKey: "LoggedIN")
        registerNotifcation()
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        authenticate()
        setsaveImage()
        print("viewDidAppear mainContainer")
             }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear mainContainer")
    }
    
    
    // MARK :- MenuContainer Function
    @IBAction func menuContainerSction(_ sender: Any) {
        
        menucallorclose()
        
    }
    
    
    func menucallorclose(){
        if menuConstraintToggle {
            UIView.animate(withDuration: 0.5) {
                self.menuContainerConstraint.constant = 265
                self.mainContainerConstraint.backgroundColor = UIColor.clear
                self.mainContainerConstraint.alpha = 1
                self.mainContainerConstraint.isOpaque = false
                
            }
            menuConstraintToggle = false
        }
        else {
            
            UIView.animate(withDuration: 0.5) {
                self.menuContainerConstraint.constant = 0
                
                self.mainContainerConstraint.backgroundColor = UIColor.black
                self.mainContainerConstraint.alpha = 0.1
                self.mainContainerConstraint.isOpaque = true
                
                
            }
            
            menuConstraintToggle = true
        }
    }


    
    
//    func  regMenucellview(){
//
//        print("register cell")
//        Menucollection.register(UINib(nibName: "HomeMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "menucellview")
//
//
//        Menucollection.layer.shadowRadius = 5
//        Menucollection.layer.shadowOpacity = 0.2
//        Menucollection.layer.shadowOffset = CGSize(width: 1, height: 5)
//        Menucollection.clipsToBounds = false
//
//    }
  
    
    // MARK :- Added Invite Function
    @IBAction func inviteButton(_ sender: Any) {
        
        print("invite");
        
    }
    
    //MARK: - Authentication Login/Signup
    
    func authenticate(){
        print("auth mainContainer")
        let userAuth = UserDefaults.standard
        if userAuth.bool(forKey: "token") {
            print("This is inside bool",true)
            let auth = userAuth.value(forKey: "LoggedIN") as! Dictionary<String,String>
            print("Auth Status ",auth["Status"]!)
            print(auth)
            if auth["Status"] ==  "success" {
                
                print("status access")
                //userAuth.removeObject(forKey: "LoggedIN")
            }
        }
        else{
            performSegue(withIdentifier: "authvc", sender: self)
            print(false)
        }
       
        

        
    }
    
    private func registerNotifcation(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateData(notification:)), name: NSNotification.Name("profileDataMain"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(menuAction(notification:)), name: NSNotification.Name("menuid"), object: nil)
    }
    
    
    @objc func updateData(notification:Notification){
        let images = notification.userInfo!["imageSet"] as! Data
        self.profileImage.image = UIImage(data: images)
        self.UserInfo.set(images, forKey: "saveImage")
    }
    @objc func menuAction(notification:Notification){
     
        let id = notification.userInfo!["id"] as! Int
        switch id {
            case 1:
                self.performSegue(withIdentifier: "upcommingevent", sender: self)
            break;
            
        case 2:
            self.performSegue(withIdentifier: "pastevent", sender: self)
            break;
        case 3:
            self.performSegue(withIdentifier: "viewpackage", sender: self)
            break;
            
        case 4:
            self.performSegue(withIdentifier: "sendrecipt", sender: self)
            break;
            
        case 5:
            //refresh
            break;
            
        case 6:
            //logout
            UserInfo.removeObject(forKey: "token")
            UserInfo.removeObject(forKey: "LoggedIN")
            performSegue(withIdentifier: "authvc", sender: self)
            break;
            
        case 7:
            //cacnel
            menucallorclose()
            break;
        
        default:
            print("default option raise in switch")
        }
        print("recivesenderid",id)
        
    }
    
    
    private func setsaveImage(){
         if let imageObj = UserInfo.object(forKey:"saveImage") {
            self.profileImage.image = UIImage(data: imageObj as! Data)

        }
        else{
            self.profileImage.image = UIImage(named: "profile")
        }
        
        if UserInfo.bool(forKey:"token"){
            let fetch  = UserInfo.value(forKey: "LoggedIN") as! Dictionary<String,String>
            profileName.text = fetch["Name"]
            profileStatus.text = "Status:\(fetch["Status"] == "success" ? "Active":"Offline")"
            profileWallet.text = UserInfo.value(forKey: "walletamount") as? String
        }
    }
    
   
    
}



