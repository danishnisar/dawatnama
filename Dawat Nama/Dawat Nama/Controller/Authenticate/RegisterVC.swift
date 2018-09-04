//
//  RegisterVC.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 06/08/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AccountKit
import ProgressHUD

class RegisterVC: UIViewController {

    
    @IBOutlet weak var name: DesignUITextField!
    @IBOutlet weak var email: DesignUITextField!
    @IBOutlet weak var password: DesignUITextField!
    @IBOutlet weak var confrimPassword: DesignUITextField!
    var phoneNumber = ""
    var fbacount:AKFAccountKit!
    let localdb = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        //MARK: - UITextField Delegation
        addDelegateandReturnType()
        
        if fbacount == nil {
            fbacount = AKFAccountKit(responseType: AKFResponseType.accessToken)
        }
    }

    //MARK: - Facebook
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        if fbacount != nil {
            fbacount.requestAccount { (acount, err) in
                if let phoneNUmber = acount?.phoneNumber {
                    
                    self.phoneNumber = phoneNUmber.stringRepresentation()
                    self.networkingStart()
                }
                print("fbsession log out")
                self.fbacount.logOut()
            }
            
        }
    }
    
    private func addDelegateandReturnType(){
        name.delegate = self
        name.returnKeyType = .next
        email.delegate = self
        name.returnKeyType = .next
        password.delegate = self
        name.returnKeyType = .next
        confrimPassword.delegate = self
        name.returnKeyType = .next
        
    }

    @IBAction func RegisterAuth(_ sender: Any) {
        if name.text != "" && name.text != "Name" || email.text != "" && email.text != "Email" || password.text != "" && password.text != "Password" || confrimPassword.text != "" && confrimPassword.text != "Confirm Password"  {
            if confrimPassword.text != password.text {
                print("confirm password doesnt matches")
                return
            }
            loginWithFacbookphoneNumber()
        }else{
            print("field is nil or space in it")
        }
        
    }
    
    
    private func networkingStart(){
        ProgressHUD.show()
            let token = "\(localdb.value(forKey: "fcmtoken")!)"
        let param = ["number":phoneNumber,"name":name.text!,"email":email.text!,"password":password.text!,"firebase_token":token]
            print("register param ",param)
            Alamofire.request(RestFull.registerURL, method: .post, parameters: param).responseJSON { (response) in
                if response.result.isSuccess{
                    ProgressHUD.showSuccess("Success")
                    print("\(response.result.value!)")
                    
                    NotificationCenter.default.post(name: NSNotification.Name("SelectSegment"), object: nil)
                }
                else{
                    ProgressHUD.showSuccess("Internet Issue")
                    print(response.result.error!)
                }
                ProgressHUD.dismiss()
            }
            
        }

    
    
    

    private func prepareLopginViewController(loginVC:AKFViewController){
        loginVC.delegate = self
        loginVC.uiManager = AKFSkinManager(skinType: .contemporary, primaryColor: UIColor.blue, backgroundImage: UIImage(named: "profile"), backgroundTint: AKFBackgroundTint.white, tintIntensity: 0.8)
    }
    
    private func loginWithFacbookphoneNumber(){
        
        let inputString = UUID().uuidString
        let fbvc = fbacount.viewControllerForPhoneLogin(with: nil, state: inputString)
        self.prepareLopginViewController(loginVC: fbvc)
        present(fbvc as UIViewController, animated: true, completion: nil)
        
    }
}

extension RegisterVC:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        NotificationCenter.default.post(name: NSNotification.Name("RegisKeyUp"), object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        switch textField {
        case name:
            email.becomeFirstResponder()
        case email:
            password.becomeFirstResponder()
        case password:
            confrimPassword.becomeFirstResponder()
        case confrimPassword:
            confrimPassword.resignFirstResponder()
        default:
            print("register deufalt")
        }
        return true
    }
    
    
}


extension RegisterVC:AKFViewControllerDelegate{
    
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didFailWithError error: Error!) {
        print("\(viewController) did fail with error \(error.localizedDescription)" )
    }
    
    func viewControllerDidCancel(_ viewController: (UIViewController & AKFViewController)!) {
        print("cacnel occur by user side")
    }
}
