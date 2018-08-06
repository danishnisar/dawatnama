//
//  loginVC.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 06/08/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class loginVC: UIViewController {

    @IBOutlet weak var phoneNumber: DesignUITextField!
    @IBOutlet weak var password: DesignUITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumber.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
extension loginVC:UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("enter in")
        NotificationCenter.default.post(name: NSNotification.Name("LoginKeyUp"), object: self)
    }
    
    
   
    
    
}







