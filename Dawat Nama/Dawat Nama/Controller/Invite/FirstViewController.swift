//
//  FirstViewController.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 31/07/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class FirstViewController: UIViewController {

    @IBOutlet weak var numberOfInvition: UITextField!
    @IBOutlet weak var amountToPaid: UITextField!
    @IBOutlet weak var digitalWallet: UITextField!
    
    let category = ["", "Mr.", "Ms.", "Mrs."]
    var numberinvite = 0;
    var walletprice = 0
    var userINFO = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()

       
        //numberOfInvition.delegate = self
        
        
        
        NetworkIng()
        
       
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        numberOfInvition.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        let fetch  = userINFO.value(forKey: "LoggedIN") as! Dictionary<String,String>
        print("dasdasdas\(fetch["Amount"]!)")
        digitalWallet.text = fetch["Amount"]!
    }
    
    @objc func textDidChange(_ textField:UITextField){
        print(textField.text!)
        if let text = Int(textField.text!){
            let getmultiply = (text * numberinvite)
            print(getmultiply)
            amountToPaid.text = "\(getmultiply)"
        }else{
            amountToPaid.text = "0"
        }
        
    }
    
    @IBAction func stepOne(_ sender: Any) {
        
        if let amountp = amountToPaid.text, let digitalW = digitalWallet.text {
            let amount = Int(amountp)!
            let wallet = Int(digitalW)!
            if amount > wallet {
                print("payment greater than")
            }else{
                performSegue(withIdentifier: "stepTwo", sender: nil)
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stepTwo" {
            let stepTwoVC = segue.destination as! SecoundViewController
            stepTwoVC.numberOfPepoleInvite = Int(numberOfInvition.text!)!
        }
        
    }
    
    
    


    
    
    
    private func NetworkIng(){
        Alamofire.request(RestFull.fetch_perInvitation).responseJSON { (response) in
            if response.result.isSuccess {
                print("\(response.result.value!)")
                let data = JSON(response.result.value!)
                self.setJson(data:data)
            }else{
                print("First View Controller alamofire error =>",response.result.error!)
            }
        }
    }
    
    
    private func setJson(data:JSON){
        let data = data["result"]["data"].stringValue
        numberinvite = Int(data)!
    }

}



