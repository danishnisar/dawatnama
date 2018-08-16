//
//  SecoundViewController.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 01/08/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SecoundViewController: UIViewController {

    var numberOfPepoleInvite = 0
    var category = [String]()
    var wed = ["Lunch","Dinner"]
    var birthday = ["Cake Cutting"]

    
    
    
    @IBOutlet weak var field1: UIView!
    @IBOutlet weak var field2: UIView!
    @IBOutlet weak var field3: UIView!
    @IBOutlet weak var field4: UIView!
    @IBOutlet weak var field5: UIView!
    @IBOutlet weak var field6: UIView!
    @IBOutlet weak var field7: UIView!
    @IBOutlet weak var field8: UIView!
    @IBOutlet weak var field9: UIView!
    @IBOutlet weak var field10: UIView!
    @IBOutlet weak var field11: UIView!
    @IBOutlet weak var field12: UIView!
    @IBOutlet weak var field13: UIView!
    
    @IBOutlet weak var field1HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field2HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var segmentHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field3HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field4HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field5HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field6HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field7HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field8HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field9HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field10HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field11HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field12HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field13HeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var invitationTitle: UILabel!
    @IBOutlet weak var invitationInput: UITextField!
    
    @IBOutlet weak var GroomTitle: UILabel!
    @IBOutlet weak var GroomInput: UITextField!
    @IBOutlet weak var segmenControll: UISegmentedControl!
    @IBOutlet weak var GrooSonTitle: UILabel!
    @IBOutlet weak var GroomSonInput: UITextField!
    
    @IBOutlet weak var WedTitle: UILabel!
    @IBOutlet weak var WedShufflebutton: UIButton!
    
    @IBOutlet weak var BrideTitle: UILabel!
    @IBOutlet weak var BrideInput: UITextField!
    @IBOutlet weak var BrideDaughterTitle: UILabel!
    @IBOutlet weak var BrideDaughterInput: UITextField!
    
    @IBOutlet weak var VenuTitle: UILabel!
    @IBOutlet weak var VenuInput: UITextField!
    @IBOutlet weak var locationInput: UITextField!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var DateInput: UITextField!
    @IBOutlet weak var DateImage: UIImageView!
    @IBOutlet weak var NikkahTimeInput: UITextField!
    @IBOutlet weak var NikkahTimeImage: UIImageView!
    @IBOutlet weak var ArrivalTimeInput: UITextField!
    @IBOutlet weak var ArrivalTimeImage: UIImageView!
    @IBOutlet weak var LunchOrDinnerInput: UITextField!
    @IBOutlet weak var LuncOrDinnerTimeInput: UITextField!
    @IBOutlet weak var LunchOrDinnerImage: UIImageView!
    
  
    @IBOutlet weak var birthdayDropInput: UITextField!
    @IBOutlet weak var birthdaytimeInput: UITextField!
    @IBOutlet weak var birthdayTimeclockimage: UIImageView!
    
    
    
    
    let pickerView1 = UIPickerView()
    let pickerView2 = UIPickerView()
    let pickerView3 = UIPickerView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(numberOfPepoleInvite)
        // Do any additional setup after loading the view.
        
        
        pickerView1.delegate = self
        pickerView1.dataSource = self
        pickerView1.showsSelectionIndicator = true
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        pickerView2.showsSelectionIndicator = true
        
        pickerView3.delegate = self
        pickerView3.dataSource = self
        pickerView3.showsSelectionIndicator = true
        invitationInput.inputView = pickerView1
        LunchOrDinnerInput.inputView = pickerView2
        birthdayDropInput.inputView = pickerView3
        
        
        addToolbar()
        NetworkFire()
        birthdayShowupof(cond: true, status: "Barat")
    }

    @IBAction func stepThree(_ sender: Any) {
        
        performSegue(withIdentifier: "upload", sender: self)
        
    }
    
    
  
    
        func addToolbar(){
            let toolbarNew = UIToolbar()
            toolbarNew.barStyle = .default
            toolbarNew.isTranslucent = true
            toolbarNew.tintColor = UIColor(red: 93/255, green: 216/255, blue: 255/255, alpha: 1)
            toolbarNew.sizeToFit()
    
            // Adding Button Toolbar
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(buttonDone))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(buttonCancel))
            toolbarNew.setItems([cancelButton,spaceButton,doneButton], animated: true)
            toolbarNew.isUserInteractionEnabled = true
            invitationInput.inputAccessoryView = toolbarNew
            birthdayDropInput.inputAccessoryView = toolbarNew
            LunchOrDinnerInput.inputAccessoryView = toolbarNew
    
        }
        @objc func buttonDone(){
            print("done Work")
            invitationInput.resignFirstResponder()
            birthdayDropInput.resignFirstResponder()
            LunchOrDinnerInput.resignFirstResponder()
        }
        @objc func buttonCancel(){
            print("cancel Work")
            invitationInput.resignFirstResponder()
            birthdayDropInput.resignFirstResponder()
            LunchOrDinnerInput.resignFirstResponder()
        }
    private func NetworkFire(){
        Alamofire.request(RestFull.fetch_Event).responseJSON { (response) in
            if response.result.isSuccess{
                let data = JSON(response.result.value!)
                self.extractJson(data:data)
                
            }else{
                print("Network error\(response.result.error!)")
            }
        }
        
        
    }
    private func extractJson(data:JSON){
        
        let parse = data["result"]["data"].count
        if parse != 0 {
            for i in 0..<parse {
              let eventName = data["result"]["data"][i]["events_name"].stringValue
                category.append(eventName)
            }
            invitationInput.text = category[0]
        }else{
            print("No Event Find")
        }
        
        
    }
    /*
     
     field1  - invitation 50
     field2 -  groom 50
     segment = segment 28
     field3  = weds button 50
     field4 = son of 50
     field5 = bride 50
     field6 = daughter of 50
     field7 = venue 50
     field8 = location 58
     field9 = date 58
     field10 = Nikkah Time 58
     field11 = Arrival Time 58
     field12 = lunch or dinner 58
     field13 = cake 58
     
     */

    
    private func birthdayShowupof(cond:Bool,status:String){
        if status  == "Birthday" {
            print("Birthday called")
            field1.isHidden = (cond == true) ? false : true
            field1HeightConstraint.constant = 50
            
            segmenControll.isHidden = (cond == true) ? false : true
            segmentHeightConstraint.constant = 28
            
            field2.isHidden = (cond == true) ? false : true
            field2HeightConstraint.constant = 50
            GroomTitle.text = "Name"
            
            field3.isHidden = cond
            field3HeightConstraint.constant = 0
            
            field4.isHidden = cond
            field4HeightConstraint.constant = 0
            
            field5.isHidden = cond
            field5HeightConstraint.constant = 0
            
            field6.isHidden = cond
            field6HeightConstraint.constant = 0
            
            field7.isHidden = (cond == true) ? false : true
            field7HeightConstraint.constant = 50
            
            field8.isHidden = (cond == true) ? false : true
            field8HeightConstraint.constant = 58
            
            field9.isHidden = (cond == true) ? false : true
            field9HeightConstraint.constant = 58
            
            field10.isHidden = cond
            field10HeightConstraint.constant = 0
            
            field11.isHidden = (cond == true) ? false : true
            field11HeightConstraint.constant = 58
            
            field12.isHidden = cond
            field12HeightConstraint.constant = 0
            
            field13.isHidden = (cond == true) ? false : true
            field13HeightConstraint.constant = 58
            
        }else if status == "Barat"{
            
            print("Barat called")
            field1.isHidden = (cond == true) ? false : true
            field1HeightConstraint.constant = 50
            segmenControll.isHidden = cond
            segmentHeightConstraint.constant = 0
            
            field2.isHidden = (cond == true) ? false : true
            field2HeightConstraint.constant = 50
            
            field3.isHidden = (cond == true) ? false : true //not britth
            field3HeightConstraint.constant = 50
            
            field4.isHidden = (cond == true) ? false : true //not britth
            field4HeightConstraint.constant = 50
            
            field5.isHidden = (cond == true) ? false : true //not britth
            field5HeightConstraint.constant = 50
            
            field6.isHidden = (cond == true) ? false : true //not britth
            field6HeightConstraint.constant = 50
            
            field7.isHidden = (cond == true) ? false : true
            field7HeightConstraint.constant = 50
            
            field8.isHidden = (cond == true) ? false : true
            field8HeightConstraint.constant = 58
            
            field9.isHidden = (cond == true) ? false : true
            field9HeightConstraint.constant = 58
            
            field10.isHidden = (cond == true) ? false : true //not britth
            field10HeightConstraint.constant = 58
            
            field11.isHidden = (cond == true) ? false : true
            field11HeightConstraint.constant = 58
            
            field12.isHidden = (cond == true) ? false : true //not britth
            field12HeightConstraint.constant = 58
            
            field13.isHidden = cond
            field13HeightConstraint.constant = 0
            
        }else{
            print("Walima And Mehndi called")
            field1.isHidden = (cond == true) ? false : true
            field1HeightConstraint.constant = 50
            
            segmenControll.isHidden = cond
            segmentHeightConstraint.constant = 0
            
            field2.isHidden = (cond == true) ? false : true
            field2HeightConstraint.constant = 50
            
            field3.isHidden = (cond == true) ? false : true //not britth
            field3HeightConstraint.constant = 50
            
            field4.isHidden = (cond == true) ? false : true //not britth
            field4HeightConstraint.constant = 50
            
            field5.isHidden = (cond == true) ? false : true //not britth
            field5HeightConstraint.constant = 50
            
            field6.isHidden = (cond == true) ? false : true //not britth
            field6HeightConstraint.constant = 50
            
            field7.isHidden = (cond == true) ? false : true
            field7HeightConstraint.constant = 50
            
            field8.isHidden = (cond == true) ? false : true
            field8HeightConstraint.constant = 58
            
            field9.isHidden = (cond == true) ? false : true
            field9HeightConstraint.constant = 58
            
            field10.isHidden = cond
            field10HeightConstraint.constant = 0
            
            field11.isHidden = (cond == true) ? false : true
            field11HeightConstraint.constant = 58
            
            field12.isHidden = (cond == true) ? false : true //not britth
            field12HeightConstraint.constant = 58
            
            field13.isHidden = cond
            field13HeightConstraint.constant = 0
            
        }
        
        self.view.layoutIfNeeded()
        
 
    }
    
   
    

}

extension SecoundViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerView1{
            return category.count
        }else if pickerView == pickerView2{
            return wed.count
        }else{
            return birthday.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1 {
            return category[row]

        }else if pickerView == pickerView2{
            return wed[row]
        }else{
            return birthday[row]
        }
    }
    
    // When user selects an option, this function will set the text of the text field to reflect
    // the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == pickerView1 {
            invitationInput.text = category[row]
            LunchOrDinnerInput.text = wed[0]
            birthdayDropInput.text = birthday[0]
            if category[row] == "Birthday"{
                 birthdayShowupof(cond: true, status: category[row])
                
            }else if category[row] == "Mehndi"{
                
                birthdayShowupof(cond: true, status: category[row])
            }else{
                
                birthdayShowupof(cond: true, status: category[row])
            }
            
        }else if pickerView == pickerView2 {
            LunchOrDinnerInput.text = wed[row]
        }else{
            birthdayDropInput.text = birthday[row]
        }
        
    }
}
