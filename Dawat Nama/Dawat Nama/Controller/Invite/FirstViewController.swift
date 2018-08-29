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
import SwiftSpinner

class FirstViewController: UIViewController {

    @IBOutlet weak var numberOfInvition: UITextField!
    @IBOutlet weak var amountToPaid: UITextField!
    @IBOutlet weak var digitalWallet: UITextField!
    
    let category = ["", "Mr.", "Ms.", "Mrs."]
    var numberinvite = 0;
    var walletprice = 0
    var dataCollect:Dictionary = [String: String]()
    
    var collectData = [String:String]()
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
       // print("dasdasdas\(fetch["Amount"]!)")
        digitalWallet.text = fetch["Amount"]!
    }
    
    @objc func textDidChange(_ textField:UITextField){
        //print(textField.text!)
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
                alertFunc()
            }
            else{
                
                //self.dismiss(animated: true, completion: nil)
                self.performSegue(withIdentifier: "stepTwo", sender: nil)
                
                
                
            }
            
        }
        
    }
    
    
    
    private func alertFunc(){
        let alert  = UIAlertController(title: "Insufficiant A ount", message: "Sorry, Your Current Wallet amouunt is insufficent for your current request .Please buy a package to recharge it ", preferredStyle: .alert)
        let packageAction = UIAlertAction(title: "Select Package", style: .default) { (response) in
            
            print("packageAction")
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (response) in
            
            print("cancelAction")
            
        }
        
        alert.addAction(cancelAction)
        alert.addAction(packageAction)
        present(alert, animated: true) {
            print("alert dismised")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stepTwo" {
            let stepTwoVC = segue.destination as! SecoundViewController
            self.dataCollect["numberofInvite"] = numberOfInvition.text!
            stepTwoVC.dataCollect = self.dataCollect
        }
        
    }
    
    
    


    
    
    
    private func NetworkIng(){
        SwiftSpinner.show("Loading.")
        
        Alamofire.request(RestFull.fetch_perInvitation).responseJSON { (response) in
            if response.result.isSuccess {
                print("firstview = \(response.result.value!)")
                let data = JSON(response.result.value!)
                self.setJson(data:data)
                SwiftSpinner.hide()
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



