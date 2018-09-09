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

    @IBOutlet weak var forgotPassword: UILabel!
    @IBOutlet weak var phoneNumber: DesignUITextField!
    @IBOutlet weak var password: DesignUITextField!
    let localdb = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumber.delegate = self
        password.delegate = self
        phoneNumber.returnKeyType = .next
        password.returnKeyType = .done
        addactionformgot()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func LogAuth(_ sender: Any) {
       
        if phoneNumber.text! != "Phone Number" && password.text! != "Password" && phoneNumber.text! != "" && password.text! != "" {
            print(phoneNumber.text!,password.text!)
            let token = "\(localdb.value(forKey: "fcmtoken")!)"
            let parameter = ["number":phoneNumber.text!,"password":password.text!,"firebase_token":token]
            print("register param ",parameter)
            AuthLogin(logUrl: RestFull.loginURL, param: parameter)
        }else{
            print("credentail dalo")
            ToastView.shared.short(self.view, txt_msg: "Please fill the field")
        }
        
    }
    
    private func AuthLogin(logUrl:String, param:Dictionary<String, String>){
        ProgressHUD.show("Authenticating..")
        Alamofire.request(logUrl, method: .post, parameters: param).responseJSON { (response) in
            
            
            if let err = response.result.error{
                ProgressHUD.showError("Loading Failed")
                print(err.localizedDescription)
                ToastView.shared.short(self.view, txt_msg: "Internet connectivity issue")
                ProgressHUD.dismiss()
                return
            }
            
            if response.result.isSuccess {
                
                let dataResult:JSON = JSON(response.result.value!)
                self.fetchJsontoObj(datajson: dataResult)
                //print(dataResult)
                
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
    
    
    func addactionformgot(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickonforgot))
        forgotPassword.isUserInteractionEnabled = true
        forgotPassword.addGestureRecognizer(tap)
    }
    @objc func clickonforgot(){
        //netowrking
        let forgotAlert = UIAlertController(title: "Forgot Password", message: "Reset Password Email sent to Registered Email", preferredStyle: .alert)
        forgotAlert.addTextField { (textfield) in
            textfield.placeholder = "Enter Email"
            textfield.addTarget(forgotAlert, action: #selector(forgotAlert.checkEMail), for: .editingChanged)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
            print("Cancel")
            
        }
        let submitAction = UIAlertAction(title: "Submit", style: .default) { (submit) in
            print("Submit")
            let data = forgotAlert.textFields?[0].text
            self.networkingForgot(email:data!)
            

        }
        submitAction.isEnabled = false
        forgotAlert.addAction(cancelAction)
        forgotAlert.addAction(submitAction)
        
        present(forgotAlert, animated: true, completion: nil)
        
    }
    
    private func networkingForgot(email:String){
        ProgressHUD.show("Authenticating..")
        let param = ["email":email]
        
        Alamofire.request(RestFull.forgotEmail, method: .post, parameters: param).responseJSON { (response) in
            
            
            if let err = response.result.error{
                ProgressHUD.showError("Loading Failed")
                print(err.localizedDescription)
                ToastView.shared.short(self.view, txt_msg: "Internet connectivity issue")
                ProgressHUD.dismiss()
                return
            }
            
            if response.result.isSuccess {
                
                let dataResult:JSON = JSON(response.result.value!)
               
                ToastView.shared.short(self.view, txt_msg: dataResult["result"]["email"].stringValue)
                // self.fetchJsontoObj(datajson: dataResult)
                print(dataResult)
                
            }
            
            
            ProgressHUD.dismiss()
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

extension UIAlertController{
    @objc func checkEMail(){
        
        if let text1 = textFields?[0].text{
            if text1.contains("@"){
                            actions[1].isEnabled = true
                            self.message = "Email is valid"
            }else{
                            actions[1].isEnabled = false
                            self.message = "Email is not valid\nReset Password Email sent to Registered Email"
                
            }

        }
        
    }
}







