//
//  RegisterVC.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 06/08/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var name: DesignUITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}

extension RegisterVC:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        NotificationCenter.default.post(name: NSNotification.Name("RegisKeyUp"), object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        name.endEditing(true)
        return true
    }
    
    
}
