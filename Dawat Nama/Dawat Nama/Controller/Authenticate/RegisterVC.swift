//
//  RegisterVC.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 06/08/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit
import Alamofire

class RegisterVC: UIViewController {

    @IBOutlet weak var name: DesignUITextField!
    @IBOutlet weak var email: DesignUITextField!
    @IBOutlet weak var password: DesignUITextField!
    @IBOutlet weak var confrimPassword: DesignUITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //MARK: - UITextField Delegation
        addDelegateandReturnType()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
