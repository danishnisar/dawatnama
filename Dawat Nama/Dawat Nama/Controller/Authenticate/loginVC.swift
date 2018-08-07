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

class loginVC: UIViewController {

    @IBOutlet weak var phoneNumber: DesignUITextField!
    @IBOutlet weak var password: DesignUITextField!
    
    
    
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
            let parameter = ["number":phoneNumber.text!,"password":password.text!]
            AuthLogin(logUrl: RestFull.loginURL, param: parameter)
        }else{
            print("credentail dalo")
        }
        
    }
    
    private func AuthLogin(logUrl:String, param:Dictionary<String, String>){
        Alamofire.request(logUrl, method: .post, parameters: param).responseJSON { (response) in
            if response.result.isSuccess {
                
                let dataResult:JSON = JSON(response.result.value!)
                self.fetchJsontoObj(datajson: dataResult)
                //print(dataResult)
            }
            else{
                print("\(response.result.error! as! String) in login")
            }
        }
    }
    
    private func fetchJsontoObj(datajson:JSON){
        
        print(datajson)
        
        
        let status = datajson["result"]["status"].stringValue
        if status == "success"{
            print("status:\(status)")
            let name = datajson["result"]["name"].stringValue
            let email = datajson["result"]["email"].stringValue
            let id = datajson["result"]["id"].stringValue
            let response = datajson["result"]["response"].stringValue
            let user_amount = datajson["result"]["user_amount"].stringValue
            let number = datajson["result"]["number"].stringValue
            
            let userData = ["Status":status,"Name":name,"Email":email,"ID":id,"Response":response,"Amount":user_amount,"Phone":number]
            
            let userINFO = UserDefaults.standard
            userINFO.set(userData, forKey: "LoggedIN")
            //userINFO.bool(forKey: "true")
            userINFO.set(true, forKey: "token")
            
//            let fetch  = userINFO.value(forKey: "LoggedIN") as! Dictionary<String,String>
//            print(fetch)
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







