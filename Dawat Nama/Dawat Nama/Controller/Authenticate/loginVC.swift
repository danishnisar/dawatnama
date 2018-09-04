//
//  loginVC.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 06/08/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ProgressHUD

class loginVC: UIViewController {

    @IBOutlet weak var phoneNumber: DesignUITextField!
    @IBOutlet weak var password: DesignUITextField!
    let localdb = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumber.delegate = self
        password.delegate = self
        phoneNumber.returnKeyType = .next
        password.returnKeyType = .done
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func LogAuth(_ sender: Any) {
       
        if phoneNumber.text! != "Phone Number" && password.text! != "Password"{
            print(phoneNumber.text!,password.text!)
            let token = "\(localdb.value(forKey: "fcmtoken")!)"
            let parameter = ["number":phoneNumber.text!,"password":password.text!,"firebase_token":token]
            print("register param ",parameter)
            AuthLogin(logUrl: RestFull.loginURL, param: parameter)
        }else{
            print("credentail dalo")
        }
        
    }
    
    private func AuthLogin(logUrl:String, param:Dictionary<String, String>){
        ProgressHUD.show("Authenticating..")
        Alamofire.request(logUrl, method: .post, parameters: param).responseJSON { (response) in
            if response.result.isSuccess {
                
                let dataResult:JSON = JSON(response.result.value!)
                self.fetchJsontoObj(datajson: dataResult)
                //print(dataResult)
                
            }
            else{
                ProgressHUD.showError("Internet issue")
                print("\(response.result.error!) in login")
            }
            
            ProgressHUD.dismiss()
        }
    }
    
    private func fetchJsontoObj(datajson:JSON){
        
        print("LoginVC data",datajson)
        
        
        let status = datajson["result"]["status"].stringValue
        if status == "success"{
            print("status:\(status)")
            let name = datajson["result"]["name"].stringValue
            let email = datajson["result"]["email"].stringValue
            let id = datajson["result"]["id"].stringValue
            let response = datajson["result"]["response"].stringValue
            let user_amount = datajson["result"]["user_amount"].stringValue
            let number = datajson["result"]["number"].stringValue
            
            let userData = ["Status":status,"Name":name,"Email":email,"ID":id,"Response":response,"Phone":number]
            //"Amount":user_amount,
            
            let userINFO = UserDefaults.standard
            userINFO.set(user_amount, forKey: "walletamount")
            userINFO.set(userData, forKey: "LoggedIN")
            //userINFO.bool(forKey: "true")
            userINFO.set(true, forKey: "token")
            
//            let fetch  = userINFO.value(forKey: "LoggedIN") as! Dictionary<String,String>
//            print(fetch)
            NotificationCenter.default.post(name: NSNotification.Name("reloaddataHome"), object: nil)
            self.dismiss(animated: true, completion: nil)
        }
        else{
            print("status:\(status)")
        }
        
        
        
        
    }
    

}
extension loginVC:UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("enter in")
        NotificationCenter.default.post(name: NSNotification.Name("LoginKeyUp"), object: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case phoneNumber:
            password.becomeFirstResponder()
            
        case password:
            password.resignFirstResponder()
            NotificationCenter.default.post(name: NSNotification.Name("KeyDown"), object: self)
            
        default:
            print("default")
        }
        
        return true
    }
    
    
   
    
    
}







